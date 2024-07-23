class ChatGroupModel {
  final int id;
  final String name;
  final String slugName;
  final String avatar;
  final String date;
  final bool isPrivate;
  final String creator;
  String lastMessage;
  String lastFile;
  int unreadMessageCount;
  String lastMessageSender;
  bool lastMessageIsRead;
  final bool isUserToUser;
  bool isOnline;

  ChatGroupModel({
    this.id = 0,
    this.name = '',
    this.slugName = '',
    this.avatar = '',
    this.date = '',
    this.isPrivate = false,
    this.creator = '',
    this.lastMessage = '',
    this.lastFile = '',
    this.isUserToUser = true,
    this.lastMessageSender = '',
    this.isOnline = false,
    this.lastMessageIsRead = false,
    this.unreadMessageCount = 0,
  });

  factory ChatGroupModel.fromJson(Map<String, Object?> json) => ChatGroupModel(
        id: (json['id'] as int?) ?? 0,
        name: (json['name'] as String?) ?? '',
        slugName: (json['slug_name'] as String?) ?? '',
        avatar: (json['avatar'] as String?) ?? '',
        date: (json['date'] as String?) ?? '',
        isPrivate: (json['is_private'] as bool?) ?? false,
        creator: (json['creator'] as String?) ?? '',
        lastMessage: (json['last_message'] as String?) ?? '',
        lastFile: (json['last_file'] as String?) ?? '',
        isUserToUser: (json['is_user_to_user'] as bool?) ??  true,
        lastMessageSender: (json['last_message_sender'] as String?) ?? '',
        isOnline: (json['is_online'] as bool?) ?? false,
        lastMessageIsRead: (json['last_message_is_read'] as bool?) ?? false,
        unreadMessageCount: (json['unread_message_count'] as int?) ?? 0,
      );

  ChatGroupModel copyWith({
    int? id,
    String? name,
    String? slugName,
    String? avatar,
    String? date,
    bool? isPrivate,
    String? creator,
    String? lastMessage,
    String? lastFile,
    String? lastMessageSender,
    bool? isUserToUser,
    bool? isOnline,
    int? unreadMessageCount,
  }) {
    return ChatGroupModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slugName: slugName ?? this.slugName,
        avatar: avatar ?? this.avatar,
        date: date ?? this.date,
        isPrivate: isPrivate ?? this.isPrivate,
        creator: creator ?? this.creator,
        lastMessage: lastMessage ?? this.lastMessage,
        lastFile: lastFile ?? this.lastFile,
        lastMessageSender: lastMessageSender ?? this.lastMessageSender,
        isUserToUser: isUserToUser ?? this.isUserToUser,
        isOnline: isOnline ?? this.isOnline,
        unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatGroupModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          slugName == other.slugName &&
          avatar == other.avatar &&
          date == other.date &&
          isPrivate == other.isPrivate &&
          creator == other.creator &&
          unreadMessageCount == other.unreadMessageCount &&
          lastMessage == other.lastMessage &&
          lastFile == other.lastFile &&
          lastMessageSender == other.lastMessageSender &&
          isUserToUser == other.isUserToUser &&
          isOnline == other.isOnline;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      slugName.hashCode ^
      avatar.hashCode ^
      date.hashCode ^
      isPrivate.hashCode ^
      creator.hashCode ^
      unreadMessageCount.hashCode ^
      lastMessage.hashCode ^
      lastFile.hashCode ^
      lastMessageSender.hashCode ^
      isUserToUser.hashCode ^
      isOnline.hashCode;

  @override
  String toString() {
    return 'ChatGroup{id: $id, name: $name, slugName: $slugName, avatar: $avatar, date: $date, isPrivate: $isPrivate, creator: $creator, unreadMessageCount: $unreadMessageCount, lastMessage: $lastMessage, lastFile: $lastFile, lastMessageSender: $lastMessageSender, isUserToUser: $isUserToUser, isOnline: $isOnline}';
  }
}
