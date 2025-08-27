part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class RequestPasswordResetEvent extends ForgotPasswordEvent {
  final String phone;

  const RequestPasswordResetEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class VerifyResetCodeEvent extends ForgotPasswordEvent {
  final String phone;
  final String code;

  const VerifyResetCodeEvent(this.phone, this.code);

  @override
  List<Object> get props => [phone, code];
}

class ResendVerificationCodeEvent extends ForgotPasswordEvent {
  final String phone;

  const ResendVerificationCodeEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  final String phone;
  final String code;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordEvent({
    required this.phone,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [phone, code, newPassword, confirmPassword];
}
