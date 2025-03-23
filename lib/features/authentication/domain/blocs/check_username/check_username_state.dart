part of 'check_username_bloc.dart';

abstract class CheckUsernameState extends Equatable {
  const CheckUsernameState();

  @override
  List<Object> get props => [];
}

class CheckUsernameInitial extends CheckUsernameState {}

class CheckUsernameLoading extends CheckUsernameState {}

class CheckUsernameSuccess extends CheckUsernameState {
  final bool isExist;
  const CheckUsernameSuccess(this.isExist);
}

class CheckUsernameFailure extends CheckUsernameState {
  final String failure;
  const CheckUsernameFailure(this.failure);
}
