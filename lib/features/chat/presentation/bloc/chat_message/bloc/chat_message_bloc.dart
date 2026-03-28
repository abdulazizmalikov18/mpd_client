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
  bool _isMessageListenerInitialized = false;

  ChatMessageBloc(this._repo) : super(const ChatMessageState()) {
    // Don't call onComingMessage() in constructor - channel might not be ready yet
    // It will be called when channel is connected in main_page.dart
    on<ChatGetMessages>(_onGetMessages);
    on<ChatGetMoreMessages>(_onGetMoreMessages);
    on<ChatSendMessageEvent>(_onSendMessage);
    on<ChatReadAllMessage>(_onReadAllMessage);
    on<ChatSocketMessage>(_onSocketMessage);
  }

  void _onGetMessages(ChatGetMessages event, Emitter emit) async {
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
        currentGroupSlug: event.group.slugName,
      ),
    );
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
          currentGroupSlug: event.group.slugName,
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
        text: event.text,
        slugName: event.groupSlug,
        file: event.file,
      ),
    );
  }

  void _onReadAllMessage(ChatReadAllMessage event, Emitter emit) async {
    await _repo.readAllMessage(event.groupSlug);
  }

  void _onSocketMessage(ChatSocketMessage event, Emitter emit) async {
    final message = event.message;

    // Only process messages for the current group
    if (state.currentGroupSlug == null ||
        message.groupSlug != state.currentGroupSlug) {
      return;
    }

    // Check if message already exists (avoid duplicates)
    final exists = state.messages.any(
      (m) => m.id == message.id && m.id != null && m.id! > 0,
    );

    if (!exists) {
      // Add new message from socket
      emit(
        state.copyWith(
          messages: [message, ...state.messages],
          status: FormzSubmissionStatus.success,
        ),
      );
    }
  }

  void onComingMessage() {
    // Note: onComingNewMessage uses broadcast stream, so multiple listeners are supported
    // We still check flag to avoid adding the same listener multiple times from the same bloc instance
    if (_isMessageListenerInitialized) {
      return; // Already initialized for this bloc instance
    }
    _isMessageListenerInitialized = true;
    ChatVMController().onComingNewMessage((message) {
      Log.e("NewMessage");
      add(ChatSocketMessage(message));
    });
  }
}
