part of 'resend_verify_card_bloc.dart';

abstract class ResendVerifyCardEvent extends Equatable {
  const ResendVerifyCardEvent();

  @override
  List<Object> get props => [];
}

class ResendVerifyCard extends ResendVerifyCardEvent {
  final int id;
  const ResendVerifyCard(this.id);
}

class StartTicker extends ResendVerifyCardEvent {
  final int duration;
  const StartTicker(this.duration);
}
