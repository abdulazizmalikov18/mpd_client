part of 'resend_pvc_bloc.dart';

enum ResendButton { initial, submitting, timing }

class ResendPvcState extends Equatable {
  final ResendButton buttonState;
  final String duration;
  final String failure;
  const ResendPvcState(
      {required this.buttonState, this.failure = '', this.duration = ''});

  ResendPvcState copyWith(
      {final ResendButton? buttonState,
      final String? failure,
      final String? duration}) {
    return ResendPvcState(
        buttonState: buttonState ?? this.buttonState,
        failure: failure ?? this.failure,
        duration: duration ?? this.duration);
  }

  @override
  List<Object?> get props => [buttonState, failure, duration];
}
