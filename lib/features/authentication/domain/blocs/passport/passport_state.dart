part of 'passport_bloc.dart';

class PassportState {
  final File? pasportImage;
  final String error;
  final bool showLoading;
  const PassportState(
      {this.pasportImage, this.error = '', this.showLoading = false});

  PassportState copyWith(
      {final File? pasportImage,
      final String? error,
      final bool? showLoading}) {
    return PassportState(
        pasportImage: pasportImage ?? this.pasportImage,
        showLoading: showLoading ?? this.showLoading,
        error: error ?? this.error);
  }
}
