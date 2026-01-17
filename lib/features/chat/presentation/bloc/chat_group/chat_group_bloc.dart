import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:mpd_client/features/chat/data/entity/get_group_chat_entity.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';

part 'chat_group_event.dart';
part 'chat_group_state.dart';

class ChatGroupBloc extends Bloc<ChatGroupEvent, ChatGroupState> {
  final ChatRepository _repo;

  ChatGroupBloc(this._repo) : super(const ChatGroupState()) {
    on<ChatGetGroupEvent>(_onGetGroup);
    on<ChatGroupSearchEvent>(_onSearchGroup);
    on<ChatMarkGroupAsRead>(_onMarkGroupAsRead);
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
}
