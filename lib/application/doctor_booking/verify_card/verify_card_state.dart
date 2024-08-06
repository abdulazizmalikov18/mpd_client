part of 'verify_card_bloc.dart';

abstract class VerifyCardState extends Equatable {
  final CardRemoteModel? card;
  const VerifyCardState(this.card);

  @override
  List<Object?> get props => [card];
}

class VerifyCardInitial extends VerifyCardState {
  const VerifyCardInitial(super.card);
}

class VerifyCardLoading extends VerifyCardState {
  const VerifyCardLoading(super.card);
}

class VerifyCardSuccess extends VerifyCardState {
  const VerifyCardSuccess(super.card);
}

class VerifyCardFailure extends VerifyCardState {
  final String failure;
  const VerifyCardFailure(this.failure, super.card);
}
