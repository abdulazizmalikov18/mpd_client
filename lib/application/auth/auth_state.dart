part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
  cancelLoading,
}

class AuthState extends Equatable {
  final UserModel userModel;
  final AuthStatus authStatus;
  final FormzSubmissionStatus status;
  final String text;

  const AuthState({
    this.userModel = const UserModel(),
    this.authStatus = AuthStatus.unauthenticated,
    this.status = FormzSubmissionStatus.initial,
    this.text = '',
  });

  @override
  List<Object?> get props => [authStatus, text];

  AuthState copyWith({
    UserModel? userModel,
    AuthStatus? authStatus,
    FormzSubmissionStatus? status,
    String? text,
  }) {
    return AuthState(
      userModel: userModel ?? this.userModel,
      authStatus: authStatus ?? this.authStatus,
      status: status ?? this.status,
      text: text ?? this.text,
    );
  }
}
