part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final String error;
  final bool isCorrect;
  final bool showLoading;
  final bool newPasswordEye;
  final bool confirmPasswordEye;

  const ChangePasswordState({
    this.error = '',
    this.showLoading = false,
    this.isCorrect = false,
    this.newPasswordEye = true,
    this.confirmPasswordEye = true,
  });

  ChangePasswordState copyWith({
    final String? error,
    final bool? showLoading,
    final bool? isCorrect,
    final bool? newPasswordEye,
    final bool? confirmPasswordEye,
  }) {
    return ChangePasswordState(
      error: error ?? this.error,
      isCorrect: isCorrect ?? this.isCorrect,
      showLoading: showLoading ?? this.showLoading,
      newPasswordEye: newPasswordEye ?? this.newPasswordEye,
      confirmPasswordEye: confirmPasswordEye ?? this.confirmPasswordEye,
    );
  }

  @override
  List<Object> get props => [
    error,
    showLoading,
    isCorrect,
    newPasswordEye,
    confirmPasswordEye,
  ];
}
