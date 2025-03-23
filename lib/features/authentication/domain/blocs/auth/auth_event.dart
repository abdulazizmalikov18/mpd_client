part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class PasswordTextFieldChanged extends AuthEvent {
  final String password;
  const PasswordTextFieldChanged(this.password);
}

class EyeIconPressed extends AuthEvent {}

class BackButtonPressed extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final VoidCallback onError;

  const LoginButtonPressed({required this.onError});
}

class RefreshToken extends AuthEvent {}

class DeleteToken extends AuthEvent {}

class ChangePhoneorUsername extends AuthEvent {
  final String value;
  const ChangePhoneorUsername(this.value);
}
