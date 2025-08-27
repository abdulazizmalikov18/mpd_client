part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus {
  initial,
  requestInProgress,
  requestSuccess,
  verifyInProgress,
  verifySuccess,
  resendInProgress,
  resendSuccess,
  resetInProgress,
  resetSuccess,
  failure,
}

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final String? phone;
  final String? code;
  final String? error;
  final bool isResendSuccess;

  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.phone,
    this.code,
    this.error,
    this.isResendSuccess = false,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? phone,
    String? code,
    String? error,
    bool? isResendSuccess,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      error: error,
      isResendSuccess: isResendSuccess ?? this.isResendSuccess,
    );
  }

  @override
  List<Object?> get props => [status, phone, code, error, isResendSuccess];
}
