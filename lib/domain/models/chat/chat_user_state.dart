
class ChatUserState {
  final String type;
  final String user;
  final bool isOnline;
  final String slugName;
  const ChatUserState({
    required this.type,
    required this.user,
    required this.isOnline,
    required this.slugName,
  });

  factory ChatUserState.fromJson(Map<String, dynamic> json) => ChatUserState(
        type: json['type'] as String? ?? '',
        user: json['user'] as String? ?? '',
        isOnline: json['is_online'] as bool? ?? false,
        slugName: json['slug_name'] as String? ?? '',
      );
}
