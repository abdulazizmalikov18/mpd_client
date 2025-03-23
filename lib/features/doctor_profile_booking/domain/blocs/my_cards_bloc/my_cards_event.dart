part of 'my_cards_bloc.dart';

abstract class MyCardsEvent extends Equatable {
  const MyCardsEvent();

  @override
  List<Object> get props => [];
}

class GetMyCardsEvent extends MyCardsEvent {}

class SelectCardEvent extends MyCardsEvent {
  final int selectedId;
  const SelectCardEvent(this.selectedId);
}

class SelectPaymentType extends MyCardsEvent {
  final PaymentMethod paymentMethod;
  const SelectPaymentType(this.paymentMethod);
}

class InsertCardToAllEvent extends MyCardsEvent {
  final CardRemoteModel card;
  const InsertCardToAllEvent(this.card);
}
