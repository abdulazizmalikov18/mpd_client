part of 'chat_message_bloc.dart';

sealed class ChatMessageEvent {
  const ChatMessageEvent();
}

class ChatGetMessages extends ChatMessageEvent {
  final ChatGroupModel group;
  const ChatGetMessages(this.group);
}

class ChatGetMoreMessages extends ChatMessageEvent {
  final ChatGroupModel group;
  const ChatGetMoreMessages(this.group);
}

class ChatSendMessageEvent extends ChatMessageEvent {
  final String text;
  final String groupSlug;
  final File? file;
  final Function() isProfanity;
  const ChatSendMessageEvent({
    required this.text,
    required this.groupSlug,
    this.file,
    required this.isProfanity,
  });
}

class ChatReadAllMessage extends ChatMessageEvent {
  final String groupSlug;
  const ChatReadAllMessage(this.groupSlug);
}

class ChatSocketMessage extends ChatMessageEvent {
  final MessageModel message;
  const ChatSocketMessage(this.message);
}

class ChatReportMessageEvent extends ChatMessageEvent {
  final int messageId;
  final String reason;
  final Function()? onSuccess;
  final Function(String)? onError;
  const ChatReportMessageEvent({
    required this.messageId,
    required this.reason,
    this.onSuccess,
    this.onError,
  });
}

class ChatBlockUserEvent extends ChatMessageEvent {
  final String username;
  final Function()? onSuccess;
  final Function(String)? onError;
  const ChatBlockUserEvent({
    required this.username,
    this.onSuccess,
    this.onError,
  });
}
