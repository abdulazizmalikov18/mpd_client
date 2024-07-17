import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:dwed_client/features/auth/data/models/user.dart';

class UserContainer extends Equatable {
  final UserModel user;
  final FormzSubmissionStatus status;

  const UserContainer({
    this.status = FormzSubmissionStatus.initial,
    this.user = const UserModel(),
  });

  UserContainer copyWith({
    UserModel? user,
    FormzSubmissionStatus? status,
  }) {
    return UserContainer(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, status];
}
