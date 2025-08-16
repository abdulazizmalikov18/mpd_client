// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  final FormzSubmissionStatus status;
  final UserAccountModel userAccount;

  const UserProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.userAccount = const UserAccountModel(),
  });

  @override
  List<Object> get props => [status, userAccount];

  UserProfileState copyWith({
    FormzSubmissionStatus? status,
    UserAccountModel? userAccount,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      userAccount: userAccount ?? this.userAccount,
    );
  }
}
