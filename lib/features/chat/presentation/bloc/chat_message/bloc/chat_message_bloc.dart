import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/chat/data/entity/get_chat_entity.dart';
import 'package:mpd_client/features/chat/data/entity/send_message_entity.dart';
import 'package:mpd_client/features/chat/data/repo/chat_repository.dart';
import 'package:mpd_client/features/chat/domain/models/chat_group.dart';
import 'package:mpd_client/features/chat/domain/models/message.dart';
import 'package:mpd_client/core/utils/profanity_filter.dart';
import 'package:mpd_client/features/chat/presentation/controller/vm_controller.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatRepository _repo;

  ChatMessageBloc(this._repo) : super(const ChatMessageState()) {
    onComingMessage();
    on<ChatGetMessages>(_onGetMessages);
    on<ChatGetMoreMessages>(_onGetMoreMessages);
    on<ChatSendMessageEvent>(_onSendMessage);
    on<ChatReadAllMessage>(_onReadAllMessage);
    on<ChatSocketMessage>(_onSocketMessage);
  }

  void _onGetMessages(ChatGetMessages event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.getMessages(
      GetChatEntity(groupSlug: event.group.slugName),
    );
    if (result.isRight) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          messages: result.right.results,
          count: result.right.count,
          offset: result.right.nextOffset,
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }

  void _onGetMoreMessages(ChatGetMoreMessages event, Emitter emit) async {
    final result = await _repo.getMessages(
      GetChatEntity(groupSlug: event.group.slugName, offset: state.offset),
    );
    if (result.isRight) {
      emit(
        state.copyWith(
          messages: [...state.messages, ...result.right.results],
          status: FormzSubmissionStatus.success,
          offset: result.right.nextOffset,
        ),
      );
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.failure));
  }

  void _onSendMessage(ChatSendMessageEvent event, Emitter emit) async {
    if (event.text.trim().isEmpty) return;

    // Check for profanity
    if (ProfanityFilter.hasProfanity(event.text)) {
      event.isProfanity();
      return;
    }

    // Filter out any profanity (alternative approach - uncomment if you want to filter instead of block)
    // final filteredText = ProfanityFilter.filterProfanity(event.text);

    ChatVMController().messageController.clear();

    await _repo.sendMessage(
      SendMessageEntity(
        text: event
            .text, // or use filteredText if you choose to filter instead of block
        slugName: event.groupSlug,
        file: event.file,
      ),
    );
  }

  void _onReadAllMessage(ChatReadAllMessage event, Emitter emit) async {
    await _repo.readAllMessage(event.groupSlug);
  }

  void _onSocketMessage(ChatSocketMessage event, Emitter emit) async {
    emit(
      state.copyWith(
        messages: [event.message, ...state.messages],
        status: FormzSubmissionStatus.success,
      ),
    );
  }

  void onComingMessage() {
    ChatVMController().onComingNewMessage((message) {
      Log.e("NewMessage");
      add(ChatSocketMessage(message));
    });
  }
}
