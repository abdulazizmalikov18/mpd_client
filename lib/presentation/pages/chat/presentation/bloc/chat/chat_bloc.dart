import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/abstract_repo/chat_repository.dart';
import 'package:mpd_client/domain/entity/chat/get_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_group_chat_entity.dart';
import 'package:mpd_client/domain/entity/chat/get_users_entity.dart';
import 'package:mpd_client/domain/entity/chat/send_message_entity.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';
import 'package:mpd_client/domain/models/chat/create_group_model.dart';
import 'package:mpd_client/domain/models/chat/message.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';
import 'package:mpd_client/main.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/container/chat_container.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/container/chat_user_container.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/container/create_group_container.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/bloc/chat/container/group_container.dart';
import 'package:mpd_client/presentation/pages/chat/presentation/controller/vm_controller.dart';
import 'package:mpd_client/utils/extensions/list_extention.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  IOWebSocketChannel? chatSocket;

  ChatBloc(this._repo) : super(const ChatState()) {
    _chatListenerConnect();
    on<GetGroupChat>(_getGroupChats);
    on<PushToChatEvent>(_pushToChat);
    on<PushToGroupEvent>(_pushToGroup);
    on<SendMessageEvent>(_sendMessage);
    on<ChatNewComeEvent>(_comingNewMessage);
    on<GroupSearchEvent>(_searchGroupEvent);
    on<GetMoreChatEvent>(_getMoreChats);
    on<GoCreateGroupEvent>(_goToCreateGroup);
    on<GroupUsersSelectionEvent>(_userSelected);
    on<GoCreateChatEvent>(_goToCreateChat);
    on<CreateChatEvent>(_createChat);
    on<CreateGroupEvent>(_createGroup);
    on<ChatComingOnlineStatusEvent>(_comingOnlineStatus);
    on<ChatConnectSocketEvent>(_reConnectChatSocket);
  }

  void _createGroup(CreateGroupEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        createGroupContainer: state.createGroupContainer.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      ),
    );
    final result = await _repo.createGroup(
      CreateGroupModel(
        name: event.name,
        slugName: event.slugName,
        avatar: event.avatar,
        chatUsers: state.createGroupContainer.selectionUser.map<String>((e) => e.username).toList(),
        isPrivate: event.isPrivate,
        isUserToUser: false,
      ),
    );

    if (result.isRight) {
      emit(
        state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            status: FormzSubmissionStatus.success,
          ),
          groupContainer: state.groupContainer.copyWith(
            groups: [result.right, ...state.groupContainer.groups],
          ),
        ),
      );
      add(const PushToGroupEvent());

      return;
    }
    emit(
      state.copyWith(
        createGroupContainer: state.createGroupContainer.copyWith(
          status: FormzSubmissionStatus.failure,
        ),
      ),
    );
    add(const PushToGroupEvent());
  }

  void _createChat(CreateChatEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        dataStatus: FormzSubmissionStatus.inProgress,
      ),
    );
    final result = await _repo.createUserChat(username: event.user.username);
    if (result.isRight) {
      emit(
        state.copyWith(
          groupContainer: state.groupContainer.copyWith(
            activeGroup: result.right,
            groups: [result.right, ...state.groupContainer.groups],
          ),
          chatContainer: state.chatContainer.copyWith(
            chats: [],
          ),
          dataStatus: FormzSubmissionStatus.success,
        ),
      );
      event.onSuccess();
      return;
    }
    event.onError();
    emit(
      state.copyWith(
        dataStatus: FormzSubmissionStatus.failure,
      ),
    );
  }

  // Navigation ----------------------------------------------------------------
  void _goToCreateChat(GoCreateChatEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        usersContainer: state.usersContainer.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      ),
    );
    final result = await _repo.getAllUsers(GetChatUserEntity(limit: 100));

    if (result.isRight) {
      final filteredUsers = filterUser(result.right.results);

      emit(
        state.copyWith(
          usersContainer: state.usersContainer.copyWith(
            users: filteredUsers,
            allUsers: filteredUsers,
            selectionUser: [],
            status: FormzSubmissionStatus.success,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          usersContainer: state.usersContainer.copyWith(
            status: FormzSubmissionStatus.failure,
          ),
        ),
      );
    }
  }

  void _goToCreateGroup(GoCreateGroupEvent event, Emitter emit) async {
    emit(
      state.copyWith(
        createGroupContainer: state.createGroupContainer.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      ),
    );
    final result = await _repo.getAllUsers(GetChatUserEntity(limit: 100));

    if (result.isRight) {
      emit(
        state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            users: filterUser(result.right.results),
            count: result.right.count,
            selectionUser: [],
            status: FormzSubmissionStatus.success,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            status: FormzSubmissionStatus.failure,
          ),
        ),
      );
    }
  }

  void _pushToGroup(PushToGroupEvent event, Emitter emit) async {
    final groups = state.groupContainer.groups;
    emit(
      state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            selectionUser: [],
            status: FormzSubmissionStatus.success,
            users: [],
            count: 0,
          ),
          usersContainer: state.usersContainer.copyWith(
            users: [],
            status: FormzSubmissionStatus.success,
            selectionUser: [],
            allUsers: [],
          ),
          groupContainer: state.groupContainer.copyWith(
            groups: groups,
            status: FormzSubmissionStatus.success,
          ),
          chatContainer: state.chatContainer.copyWith(
            chats: [],
          )),
    );
    final result = await _repo.getMyChat(const GetGroupChatEntity());
    if (result.isRight) {
      emit(
        state.copyWith(
          groupContainer: state.groupContainer.copyWith(
            status: FormzSubmissionStatus.success,
            groups: result.right.results,
          ),
        ),
      );
      return;
    }
  }

  void _pushToChat(PushToChatEvent event, Emitter emit) async {
    final foundIndex = state.groupContainer.groups.findIndex((value) => value.slugName == event.slugName) ?? 0;

    emit(
      state.copyWith(
        groupContainer: state.groupContainer.copyWith(
          activeGroup: state.groupContainer.groups[foundIndex],
        ),
        dataStatus: FormzSubmissionStatus.inProgress,
      ),
    );

    final result = await _repo.getChats(GetChatEntity(groupSlug: event.slugName, limit: 20));
    if (result.isRight) {
      final activeGroup = state.groupContainer.groups[foundIndex];
      state.groupContainer.groups[foundIndex] = activeGroup.copyWith();
      emit(
        state.copyWith(
          chatContainer: state.chatContainer.copyWith(
            chats: result.right.results,
            count: result.right.count,
            next: result.right.next,
            nextOffset: result.right.nextOffset,
          ),
          groupContainer: state.groupContainer.copyWith(
            activeGroup: activeGroup,
          ),
          dataStatus: FormzSubmissionStatus.success,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        dataStatus: FormzSubmissionStatus.failure,
        error: "Chat topilmadi",
      ),
    );
  }

  // Connection ----------------------------------------------------------------
  void _reConnectChatSocket(ChatConnectSocketEvent event, Emitter emit) {
    _chatListenerConnect();
  }

  void _chatListenerConnect() async {
    chatSocket = IOWebSocketChannel.connect(Uri.parse("${$baseUrlSocket}:80/SMMS/ws/chat/?token=${StorageRepository.getString(StorageKeys.TOKEN)}"));
    await chatSocket?.ready;
    chatSocket?.stream.listen((event) {
      try {
        Log.i("New Chat Message $event \nType${event.runtimeType}");
        final eventData = (jsonDecode(event));
        if (eventData is Map<String, dynamic>) {
          if (eventData.containsValue("online_status")) {
            add(ChatComingOnlineStatusEvent(status: eventData));
            return;
          } else if (eventData.containsValue("notify_about_message")) {
            final newMessage = MessageModel.fromSocket(eventData);
            add(ChatNewComeEvent(newMessage: newMessage));
            return;
          } else {}
          return;
        }
      } catch (e, s) {
        Log.e("error $e Stack $s");
        throw Exception("Modelga o'tkasa olmadi Message : data : $event");
      }
    }, onError: (e, s) {
      _chatListenerConnect();
    });
  }

  void _comingNewMessage(ChatNewComeEvent event, Emitter emit) {
    if (!event.newMessage.isMe) {
      $chatController.chatNotifier.value = '${event.newMessage.sender}dan Yangi habar';
    }
    final foundIndex = (state.groupContainer.groups).findIndex(
      (value) => value.slugName == event.newMessage.groupSlug,
    );

    if (foundIndex != null) {
      changeFirstChatIndex(foundIndex: foundIndex, emit: emit);

      // If is my Message Not Add
      if (event.newMessage.isMe) return;

      /// In Chats Coming New Message
      if (event.newMessage.groupSlug == state.groupContainer.activeGroup!.slugName) {
        final newState = state.groupContainer.groups;
        newState[foundIndex].lastMessage = event.newMessage.text ?? '';
        newState[foundIndex].lastFile = event.newMessage.file ?? '';
        emit(
          state.copyWith(
            groupContainer: state.groupContainer.copyWith(groups: newState),
            chatContainer: state.chatContainer.copyWith(
              chats: [event.newMessage, ...state.chatContainer.chats],
            ),
            textForUpdate: const Uuid().v4(),
          ),
        );
      }
      final newState = state.groupContainer.groups;
      newState[foundIndex].unreadMessageCount = newState[foundIndex].unreadMessageCount + 1;
      newState[foundIndex].lastMessage = event.newMessage.text ?? '';
      newState[foundIndex].lastFile = event.newMessage.file ?? '';
      emit(
        state.copyWith(
          groupContainer: state.groupContainer.copyWith(
            groups: newState,
          ),
          textForUpdate: const Uuid().v4(),
        ),
      );
    }
  }

  void _comingOnlineStatus(ChatComingOnlineStatusEvent event, Emitter emit) {
    if (!event.status.containsKey("slug_name")) return;
    final find = _findGroup(event.status["slug_name"] as String);
    if (find == null) return;
    final newGroup = state.groupContainer.groups;
    newGroup[find.$1] = find.$2.copyWith(
      isOnline: event.status["is_online"] as bool,
    );
    emit(
      state.copyWith(
        textForUpdate: const Uuid().v4(),
        groupContainer: state.groupContainer.copyWith(
          groups: List.from(newGroup),
        ),
      ),
    );
  }

  // Chat ----------------------------------------------------------------------

  void _getMoreChats(GetMoreChatEvent event, Emitter emit) async {
    if (state.chatContainer.next != null) {
      final result = await _repo.getChats(GetChatEntity(
        groupSlug: state.groupContainer.activeGroup!.slugName,
        limit: 10,
        offset: state.chatContainer.nextOffset,
      ));
      if (result.isRight) {
        emit(
          state.copyWith(
            chatContainer: state.chatContainer.copyWith(
              chats: [...state.chatContainer.chats, ...result.right.results],
              count: result.right.count,
              next: result.right.next,
              nextOffset: result.right.nextOffset,
            ),
            dataStatus: FormzSubmissionStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            dataStatus: FormzSubmissionStatus.failure,
            error: result.left.errorMessage,
          ),
        );
      }
    }
  }

  void _getGroupChats(GetGroupChat event, Emitter emit) async {
    emit(
      state.copyWith(
        groupContainer: state.groupContainer.copyWith(
          status: FormzSubmissionStatus.inProgress,
          groups: null,
        ),
      ),
    );
    final result = await _repo.getMyChat(const GetGroupChatEntity());
    if (result.isRight) {
      print("right");
      print(result.right);
      emit(
        state.copyWith(
          textForUpdate: const Uuid().v4(),
          groupContainer: state.groupContainer.copyWith(
            status: FormzSubmissionStatus.success,
            groups: [...?result.right.results],
          ),
        ),
      );
      return;
    }
    print("left");
    print(result.left);
    emit(
      state.copyWith(
        groupContainer: state.groupContainer.copyWith(
          status: FormzSubmissionStatus.failure,
          groups: result.right.results,
        ),
        error: result.left.errorMessage,
      ),
    );
  }

  void _sendMessage(SendMessageEvent event, Emitter emit) async {
    final foundIndex = state.groupContainer.groups.findIndex((value) => value.slugName == event.slugName) ?? 0;
    changeFirstChatIndex(foundIndex: foundIndex, emit: emit);

    final newMessageId = const Uuid().v4();
    final message = MessageModel(
      id: (state.chatContainer.chats.isEmpty) ? 0 : (state.chatContainer.chats.last.id ?? 0) + 1,
      text: event.text,
      file: event.file?.path,
      groupSlug: event.slugName,
      sender: StorageRepository.getString(StorageKeys.USERNAME),
      date: DateTime.now().toString(),
      isMe: true,
      isSend: false,
      sendId: newMessageId,
      isLocalFile: true,
      isRead: false,
    );

    emit(
      state.copyWith(
        chatContainer: state.chatContainer.copyWith(
          chats: [
            message,
            ...state.chatContainer.chats,
          ],
        ),
      ),
    );

    final result = await _repo.sendMessage(SendMessageEntity(text: event.text, slugName: event.slugName, file: event.file));

    if (result.isRight) {
      emit(
        state.copyWith(
          chatContainer: state.chatContainer.copyWith(
            chats: state.chatContainer.chats,
          ),
          dataStatus: FormzSubmissionStatus.success,
        ),
      );
    }
    print(StorageRepository.getString(StorageKeys.USERNAME));
  }

  // Group ---------------------------------------------------------------------
  void _searchGroupEvent(GroupSearchEvent event, Emitter emit) async {
    //   if (state.screenStatus == ChatScreenStatus.createChat) {
    //     emit(
    //       state.copyWith(
    //         usersContainer: state.usersContainer.copyWith(
    //           status: FormzSubmissionStatus.inProgress,
    //         ),
    //       ),
    //     );
    //     final result = await getAllUsers.call(GetChatUserEntity(search: event.search.isNotEmpty ? event.search : null));
    //     if (result.isRight) {
    //       emit(
    //         state.copyWith(
    //           usersContainer: state.usersContainer.copyWith(
    //             users: filterUser(result.right.results),
    //             status: FormzSubmissionStatus.success,
    //           ),
    //         ),
    //       );
    //       return;
    //     }
    //     emit(
    //       state.copyWith(
    //         usersContainer: state.usersContainer.copyWith(
    //           status: FormzSubmissionStatus.failure,
    //         ),
    //       ),
    //     );
    //     return;
    //   }
    //   if (state.screenStatus == ChatScreenStatus.createGroup) {
    //     emit(
    //       state.copyWith(
    //         createGroupContainer: state.createGroupContainer.copyWith(
    //           status: FormzSubmissionStatus.inProgress,
    //         ),
    //       ),
    //     );
    //     final result = await getAllUsers.call(GetChatUserEntity(search: event.search.isNotEmpty ? event.search : null, limit: 100));
    //     if (result.isRight) {
    //       emit(
    //         state.copyWith(
    //           usersContainer: state.usersContainer.copyWith(
    //             status: FormzSubmissionStatus.success,
    //             users: result.right.results,
    //           ),
    //         ),
    //       );
    //     }
    //     emit(
    //       state.copyWith(
    //         usersContainer: state.usersContainer.copyWith(
    //           status: FormzSubmissionStatus.success,
    //           users: [],
    //         ),
    //       ),
    //     );
    //     return;
    //   }
    //   if (event.search.isEmpty) {
    //     emit(
    //       state.copyWith(
    //         dataStatus: FormzSubmissionStatus.success,
    //         groupContainer: state.groupContainer.copyWith(
    //           groups: state.groupContainer.groups,
    //         ),
    //         textForUpdate: const Uuid().v4(),
    //       ),
    //     );
    //   }
    //
    //   emit(
    //     state.copyWith(
    //       dataStatus: FormzSubmissionStatus.success,
    //       groupContainer: state.groupContainer.copyWith(
    //         groups: state.groupContainer.groups,
    //       ),
    //       textForUpdate: const Uuid().v4(),
    //     ),
    //   );
    //   return;
  }

  void _userSelected(GroupUsersSelectionEvent event, Emitter emit) {
    emit(
      state.copyWith(
        createGroupContainer: state.createGroupContainer.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ),
      ),
    );
    if (!event.isActive) {
      final users = state.createGroupContainer.selectionUser.where((element) => element.username != event.user.username).toList();
      emit(
        state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            selectionUser: users,
            status: FormzSubmissionStatus.success,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          createGroupContainer: state.createGroupContainer.copyWith(
            selectionUser: [...state.createGroupContainer.selectionUser, event.user],
            status: FormzSubmissionStatus.success,
          ),
        ),
      );
    }
  }

  List<ChatUserModel> filterUser(List<ChatUserModel> users) {
    return users.where((element) {
      return (!state.groupContainer.groups.findExist((value) => value.slugName == element.name && (value.isUserToUser)));
    }).toList();
  }

  void changeFirstChatIndex({required int foundIndex, required Emitter emit}) {
    final groups = state.groupContainer.groups;
    final group = state.groupContainer.groups[foundIndex];
    groups.removeAt(foundIndex);

    emit(
      state.copyWith(
        groupContainer: state.groupContainer.copyWith(
          groups: [group, ...groups],
        ),
      ),
    );
  }

  (int index, ChatGroupModel group)? _findGroup(String slugName) {
    for (int i = 0; i < (state.groupContainer.groups.length); i++) {
      if (state.groupContainer.groups[i].slugName == slugName) {
        return (i, state.groupContainer.groups[i]);
      }
    }
    return null;
  }
}
