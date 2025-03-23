part of 'resend_pvc_bloc.dart';

abstract class ResendPvcEvent extends Equatable {
  const ResendPvcEvent();

  @override
  List<Object> get props => [];
}

class ResendPvc extends ResendPvcEvent {
  final String phone;
  const ResendPvc(this.phone);
}

class StartTicker extends ResendPvcEvent {
  final int duration;
  const StartTicker(this.duration);
}
