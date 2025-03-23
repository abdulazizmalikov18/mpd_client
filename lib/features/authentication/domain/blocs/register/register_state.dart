part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isPrivacyReat;
  final String error;
  final bool showLoading;
  const RegisterState(
      {this.isPrivacyReat = false, this.error = '', this.showLoading = false});

  RegisterState copyWith(
      {final bool? isPrivacyReat,
      final String? error,
      final bool? showLoading}) {
    return RegisterState(
        isPrivacyReat: isPrivacyReat ?? this.isPrivacyReat,
        showLoading: showLoading ?? this.showLoading,
        error: error ?? this.error);
  }

  @override
  List<Object> get props => [isPrivacyReat, showLoading, error];
}
