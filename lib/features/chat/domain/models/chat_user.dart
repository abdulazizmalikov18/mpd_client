class ChatUserModel {
  final String username;
  final String name;
  final String lastname;
  final String avatar;
  final String job;
  final String pinfl;

  const ChatUserModel({
    this.username = '',
    this.name = '',
    this.lastname = '',
    this.avatar = '',
    this.job = '',
    this.pinfl = '',
  });

  Map<String, Object?> toJson() {
    return {
      'username': username,
      'name': name,
      'lastname': lastname,
      'avatar': avatar,
      'job': job,
      'pinfl': pinfl,
    };
  }

  factory ChatUserModel.fromJson(Map<String, Object?> json) {
    return ChatUserModel(
      username: json['username'] as String,
      name: json['name'] as String,
      lastname: json['lastname'] == null ? '' : json['lastname'] as String,
      avatar: json['avatar'] == null ? '' : json['avatar'] as String,
      job: json['job'] == null ? '' : json['job'] as String,
      pinfl: json['pinfl'] == null ? '' : json['pinfl'] as String,
    );
  }

  @override
  String toString() {
    return 'ChatUser{username: $username, name: $name, lastname: $lastname, avatar: $avatar, job: $job, pinfl: $pinfl}';
  }
}
