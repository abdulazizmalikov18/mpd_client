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
  const ChatSendMessageEvent({
    required this.text,
    required this.groupSlug,
    this.file,
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
