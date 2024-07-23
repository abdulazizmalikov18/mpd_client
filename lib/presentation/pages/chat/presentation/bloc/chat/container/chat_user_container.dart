import 'package:formz/formz.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';

class ChatUsersContainer {
  final List<ChatUserModel> users;
  final List<ChatUserModel> allUsers;
  final FormzSubmissionStatus status;

  const ChatUsersContainer({
    required this.users,
    required this.allUsers,
    this.status = FormzSubmissionStatus.initial,
  });

  ChatUsersContainer copyWith({
    List<ChatUserModel>? users,
    List<ChatUserModel>? allUsers,
    List<ChatUserModel>? selectionUser,
    FormzSubmissionStatus? status,
  }) {
    return ChatUsersContainer(
      users: users ?? this.users,
      allUsers: allUsers ?? this.allUsers,
      status: status ?? this.status,
    );
  }

}
