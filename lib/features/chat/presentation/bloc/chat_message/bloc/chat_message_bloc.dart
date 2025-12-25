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
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
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
    on<ChatReportMessageEvent>(_onReportMessage);
    on<ChatBlockUserEvent>(_onBlockUser);
  }

  // Helper method to filter out blocked users' messages
  List<MessageModel> _filterBlockedUsers(List<MessageModel> messages) {
    try {
      final blockedUsersStr = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
      if (blockedUsersStr.isEmpty) return messages;
      final blockedUsers = blockedUsersStr.split(',').toSet();
      return messages.where((message) => 
        message.sender == null || !blockedUsers.contains(message.sender)
      ).toList();
    } catch (e) {
      Log.e('Error filtering blocked users: $e');
      return messages;
    }
  }

  void _onGetMessages(ChatGetMessages event, Emitter emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _repo.getMessages(
      GetChatEntity(groupSlug: event.group.slugName),
    );
    if (result.isRight) {
      final filteredMessages = _filterBlockedUsers(result.right.results);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          messages: filteredMessages,
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
      final filteredMessages = _filterBlockedUsers(result.right.results);
      emit(
        state.copyWith(
          messages: [...state.messages, ...filteredMessages],
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
    // Filter out blocked users' messages
    try {
      final blockedUsersStr = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
      if (blockedUsersStr.isNotEmpty) {
        final blockedUsers = blockedUsersStr.split(',').toSet();
        if (event.message.sender != null && 
            blockedUsers.contains(event.message.sender)) {
          // Don't add message from blocked user
          return;
        }
      }
    } catch (e) {
      Log.e('Error checking blocked user: $e');
    }

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

  Future<void> _onReportMessage(
    ChatReportMessageEvent event,
    Emitter emit,
  ) async {
    final result = await _repo.reportMessage(
      messageId: event.messageId,
      reason: event.reason,
    );

    if (result.isRight) {
      // Save reported message id to storage
      try {
        final current = StorageRepository.getString(
          StorageKeys.REPORTED_MESSAGES,
        );
        final reported = current.isEmpty
            ? <String>{}
            : current.split(',').toSet();
        reported.add(event.messageId.toString());
        await StorageRepository.putString(
          StorageKeys.REPORTED_MESSAGES,
          reported.where((e) => e.isNotEmpty).join(','),
        );
      } catch (e) {
        Log.e('Error saving reported message: $e');
      }

      // Remove reported message from current state immediately
      final messages = state.messages
          .where((m) => m.id != event.messageId)
          .toList();
      emit(state.copyWith(messages: messages));
      event.onSuccess?.call();
    } else {
      event.onError?.call(result.left.message.isNotEmpty 
          ? result.left.message 
          : 'Failed to report message');
    }
  }

  Future<void> _onBlockUser(
    ChatBlockUserEvent event,
    Emitter emit,
  ) async {
    final result = await _repo.blockUser(username: event.username);

    if (result.isRight) {
      // Save blocked user to storage
      try {
        final current = StorageRepository.getString(StorageKeys.BLOCKED_USERS);
        final blocked = current.isEmpty
            ? <String>{}
            : current.split(',').toSet();
        blocked.add(event.username);
        await StorageRepository.putString(
          StorageKeys.BLOCKED_USERS,
          blocked.where((e) => e.isNotEmpty).join(','),
        );
      } catch (e) {
        Log.e('Error saving blocked user: $e');
      }

      // Remove blocked user's messages from current state immediately
      final messages = state.messages
          .where((m) => m.sender != event.username)
          .toList();
      emit(state.copyWith(messages: messages));
      event.onSuccess?.call();
    } else {
      event.onError?.call(result.left.message.isNotEmpty 
          ? result.left.message 
          : 'Failed to block user');
    }
  }
}
