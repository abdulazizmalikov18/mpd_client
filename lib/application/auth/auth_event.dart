part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthStatusChanged extends AuthEvent {
  final AuthStatus status;

  const AuthStatusChanged(this.status);
}

class LoginEvent extends AuthEvent {
  final String login;
  final String password;
  final void Function() onSuccess;
  final void Function(String error) onError;

  const LoginEvent({
    required this.login,
    required this.password,
    required this.onSuccess,
    required this.onError,
  });
}

class Logout extends AuthEvent {
  const Logout();
}

class GetUserAuthEvent extends AuthEvent {
  const GetUserAuthEvent();
}
