import 'package:formz/formz.dart';
import 'package:mpd_client/domain/models/chat/chat_user.dart';

class CreateGroupContainer {
  final List<ChatUserModel> users;
  final List<ChatUserModel> selectionUser;
  final FormzSubmissionStatus status;
  final int count;

  const CreateGroupContainer({
    required this.users,
    required this.selectionUser,
    this.status = FormzSubmissionStatus.initial,
    this.count = 0,
  });

  CreateGroupContainer copyWith({
    List<ChatUserModel>? users,
    List<ChatUserModel>? selectionUser,
    FormzSubmissionStatus? status,
    int? count,
  }) {
    return CreateGroupContainer(
      users: users ?? this.users,
      selectionUser: selectionUser ?? this.selectionUser,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateGroupContainer &&
          runtimeType == other.runtimeType &&
          users == other.users &&
          selectionUser == other.selectionUser &&
          status == other.status &&
          count == other.count;

  @override
  int get hashCode => users.hashCode ^ selectionUser.hashCode ^ status.hashCode ^ count.hashCode;
}
