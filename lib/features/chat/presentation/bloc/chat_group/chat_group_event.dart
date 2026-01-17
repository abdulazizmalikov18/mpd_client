part of 'chat_group_bloc.dart';

sealed class ChatGroupEvent {
  const ChatGroupEvent();
}

class ChatGetGroupEvent extends ChatGroupEvent {
  const ChatGetGroupEvent();
}

class ChatGroupSearchEvent extends ChatGroupEvent {
  final String search;
  const ChatGroupSearchEvent({required this.search});
}

class ChatMarkGroupAsRead extends ChatGroupEvent {
  final String groupSlug;
  const ChatMarkGroupAsRead({required this.groupSlug});
}
