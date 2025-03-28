part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final FormzSubmissionStatus dataStatus;
  final String? error;
  final ChatUsersContainer usersContainer;
  final CreateGroupContainer createGroupContainer;
  final ChatContainer chatContainer;
  final GroupContainer groupContainer;
  final String textForUpdate;

  const ChatState({
    this.dataStatus = FormzSubmissionStatus.initial,
    this.error,
    this.groupContainer = const GroupContainer(),
    this.usersContainer = const ChatUsersContainer(
      users: [],
      allUsers: [],
    ),
    this.createGroupContainer = const CreateGroupContainer(
      users: [],
      selectionUser: [],
    ),
    this.chatContainer = const ChatContainer(chats: []),
    this.textForUpdate = "",
  });

  @override
  List<Object?> get props => [
        dataStatus,
        error,
        usersContainer,
        createGroupContainer,
        chatContainer,
        groupContainer,
        textForUpdate,
      ];

  ChatState copyWith({
    FormzSubmissionStatus? dataStatus,
    String? error,
    ChatUsersContainer? usersContainer,
    CreateGroupContainer? createGroupContainer,
    ChatContainer? chatContainer,
    GroupContainer? groupContainer,
    String? textForUpdate,
  }) {
    return ChatState(
      dataStatus: dataStatus ?? this.dataStatus,
      error: error ?? this.error,
      usersContainer: usersContainer ?? this.usersContainer,
      createGroupContainer: createGroupContainer ?? this.createGroupContainer,
      chatContainer: chatContainer ?? this.chatContainer,
      groupContainer: groupContainer ?? this.groupContainer,
      textForUpdate: textForUpdate ?? this.textForUpdate,
    );
  }
}
