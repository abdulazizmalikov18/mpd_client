part of 'insert_card_bloc.dart';

abstract class InsertCardState extends Equatable {
  final CardRemoteModel? card;
  const InsertCardState(this.card);

  @override
  List<Object?> get props => [card];
}

class InsertCardInitial extends InsertCardState {
  const InsertCardInitial(super.card);
}

class InsertCardLoading extends InsertCardState {
  const InsertCardLoading(super.card);
}

class InsertCardSuccess extends InsertCardState {
  const InsertCardSuccess(super.card);
}

class InsertCardFailure extends InsertCardState {
  final String failure;
  const InsertCardFailure(this.failure, super.card);
}
