import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:mpd_client/features/chat/data/entity/get_group_chat_entity.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';

part 'chat_group_event.dart';
part 'chat_group_state.dart';

class ChatGroupBloc extends Bloc<ChatGroupEvent, ChatGroupState> {
  final ChatRepository _repo;

  ChatGroupBloc(this._repo) : super(const ChatGroupState()) {
    on<ChatGetGroupEvent>(_onGetGroup);
    on<ChatGroupSearchEvent>(_onSearchGroup);
    on<ChatMarkGroupAsRead>(_onMarkGroupAsRead);
    on<ChatSocketMessageGroup>(_onSocketMessageGroup);
  }

  void _onGetGroup(ChatGetGroupEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final result = await _repo.getGroups(const GetGroupChatEntity());
    if (result.isRight) {
      emit(
        state.copyWith(
          groups: result.right.results,
          status: FormzSubmissionStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _onSearchGroup(ChatGroupSearchEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final result = await _repo.getGroups(
      GetGroupChatEntity(search: event.search),
    );
    if (result.isRight) {
      emit(
        state.copyWith(
          groups: result.right.results,
          status: FormzSubmissionStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _onMarkGroupAsRead(ChatMarkGroupAsRead event, Emitter emit) {
    final updatedGroups = state.groups.map((group) {
      if (group.slugName == event.groupSlug) {
        return group.copyWith(unreadMessageCount: 0);
      }
      return group;
    }).toList();

    emit(state.copyWith(groups: updatedGroups));
  }

  void _onSocketMessageGroup(ChatSocketMessageGroup event, Emitter emit) {
    final message = event.message;
    final groupSlug = message.groupSlug;

    if (groupSlug == null || groupSlug.isEmpty) return;

    // Find the group by slug
    final groupIndex = state.groups.indexWhere(
      (group) => group.slugName == groupSlug,
    );

    if (groupIndex == -1) {
      // Group not found, refresh the list
      add(const ChatGetGroupEvent());
      return;
    }

    // Update the group with new message
    final updatedGroups = List<ChatGroupModel>.from(state.groups);
    final group = updatedGroups[groupIndex];

    // Create updated group
    final updatedGroup = group.copyWith(
      lastMessage: message.text ?? '',
      lastFile: message.file ?? '',
      lastMessageSender: message.sender ?? '',
      date: message.date ?? DateTime.now().toIso8601String(),
      unreadMessageCount: message.isMe
          ? group.unreadMessageCount
          : group.unreadMessageCount + 1,
    );

    // Remove group from current position
    updatedGroups.removeAt(groupIndex);
    // Add to the top (most recent messages first)
    updatedGroups.insert(0, updatedGroup);

    emit(state.copyWith(groups: updatedGroups));
  }
}
