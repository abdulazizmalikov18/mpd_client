part of 'auth_bloc.dart';

enum PhoneOrUsername { initial, phone, username }

class AuthState extends Equatable {
  final bool showLoginButtonLoading;
  final String password;
  final bool obscureText;
  final String error;
  final bool isDeletedToken;
  final PhoneOrUsername phoneOrUsername;

  const AuthState(
      {this.showLoginButtonLoading = false,
      this.password = '',
      this.obscureText = true,
      this.phoneOrUsername = PhoneOrUsername.initial,
      this.error = '',
      this.isDeletedToken = false});

  AuthState copyWith(
      {final bool? showLoginButtonLoading,
      final String? phone,
      final String? password,
      final bool? obscureText,
      final String? error,
      final PhoneOrUsername? phoneOrUsername,
      final bool? isDeletedToken}) {
    // debugPrint('Error ------------- $error');
    return AuthState(
        showLoginButtonLoading:
            showLoginButtonLoading ?? this.showLoginButtonLoading,
        password: password ?? this.password,
        obscureText: obscureText ?? this.obscureText,
        error: error ?? this.error,
        phoneOrUsername: phoneOrUsername ?? this.phoneOrUsername,
        isDeletedToken: isDeletedToken ?? this.isDeletedToken);
  }

  @override
  List<Object> get props => [
        showLoginButtonLoading,
        password,
        obscureText,
        error,
        phoneOrUsername,
        isDeletedToken
      ];
}
