part of 'create_user_bloc.dart';

enum Gender { initial, male, female }

class CreateUserState extends Equatable {
  final Gender gender;
  final bool showLoading;
  final String error;
  const CreateUserState(
      {this.gender = Gender.male, this.showLoading = false, this.error = ''});

  CreateUserState copyWith(
      {final Gender? gender, final bool? showLoading, final String? error}) {
    return CreateUserState(
        gender: gender ?? this.gender,
        showLoading: showLoading ?? this.showLoading,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [gender, showLoading, error];
}
