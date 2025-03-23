part of 'verification_bloc.dart';

class VerificationState extends Equatable {
  final String error;
  final bool showLoading;
  final bool isNewUser;
  const VerificationState(
      {this.error = '', this.showLoading = false, this.isNewUser = false});

  VerificationState copyWith(
      {final String? error, final bool? showLoading, final bool? isNewUser}) {
    return VerificationState(
        error: error ?? this.error,
        showLoading: showLoading ?? this.showLoading,
        isNewUser: isNewUser ?? this.isNewUser);
  }

  @override
  List<Object> get props => [error, showLoading];
}
