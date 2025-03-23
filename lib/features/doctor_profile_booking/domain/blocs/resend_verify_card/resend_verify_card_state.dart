part of 'resend_verify_card_bloc.dart';

abstract class ResendVerifyCardState extends Equatable {
  final String duration;
  const ResendVerifyCardState(this.duration);

  @override
  List<Object> get props => [duration];
}

class ResendVerifyCardInitial extends ResendVerifyCardState {
  const ResendVerifyCardInitial(super.duration);
}

class ResendVerifyCardLoading extends ResendVerifyCardState {
  const ResendVerifyCardLoading(super.duration);
}

class ResendVerifyCardSuccess extends ResendVerifyCardState {
  const ResendVerifyCardSuccess(super.duration);
}

class ResendVerifyCardFailure extends ResendVerifyCardState {
  final String failure;
  const ResendVerifyCardFailure(this.failure, super.duration);
}
