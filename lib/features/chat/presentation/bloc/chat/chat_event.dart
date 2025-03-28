part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class GetGroupChat extends ChatEvent {
  const GetGroupChat();
}

class PushToChatEvent extends ChatEvent {
  final String slugName;

  const PushToChatEvent({required this.slugName});
}

class PushToGroupEvent extends ChatEvent {
  const PushToGroupEvent();
}

class SendMessageEvent extends ChatEvent {
  final String slugName;
  final String text;
  final File? file;

  const SendMessageEvent({
    required this.slugName,
    required this.text,
    this.file,
  });
}

class ChatNewComeEvent extends ChatEvent {
  final MessageModel newMessage;

  const ChatNewComeEvent({
    required this.newMessage,
  });
}

class ChatComingOnlineStatusEvent extends ChatEvent {
  final Map<String, Object?> status;

  const ChatComingOnlineStatusEvent({
    required this.status,
  });
}

class GroupSearchEvent extends ChatEvent {
  final String search;

  const GroupSearchEvent({required this.search});
}

class GetMoreChatEvent extends ChatEvent {
  const GetMoreChatEvent();
}

class GoCreateGroupEvent extends ChatEvent {
  const GoCreateGroupEvent();
}

class CreateGroupEvent extends ChatEvent {
  final String name;
  final String? slugName;
  final String? avatar;
  final bool? isPrivate;

  const CreateGroupEvent({
    required this.name,
    this.slugName,
    this.avatar,
    this.isPrivate,
  });
}

class GoCreateChatEvent extends ChatEvent {
  const GoCreateChatEvent();
}

class CreateChatEvent extends ChatEvent {
  final ChatUserModel user;
  final void Function() onSuccess;
  final void Function() onError;

  const CreateChatEvent({
    required this.user,
    required this.onSuccess,
    required this.onError,
  });
}

class GroupUsersSelectionEvent extends ChatEvent {
  final ChatUserModel user;
  final bool isActive;

  const GroupUsersSelectionEvent({required this.isActive, required this.user});
}

class ChatConnectSocketEvent extends ChatEvent {
  const ChatConnectSocketEvent();
}
