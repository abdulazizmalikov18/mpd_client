part of 'my_cards_bloc.dart';

enum PaymentMethod { paymeCard, paymeApp, click, cash }

abstract class MyCardsState {
  final List<CardRemoteModel> cards;
  final int selectId;
  final PaymentMethod paymentMethod;
  const MyCardsState(
      {required this.cards,
      required this.selectId,
      this.paymentMethod = PaymentMethod.paymeCard});
}

class MyCardsInitial extends MyCardsState {
  const MyCardsInitial(
      {required super.cards, required super.selectId, super.paymentMethod});
}

class MyCardsLoading extends MyCardsState {
  const MyCardsLoading(
      {required super.cards, required super.selectId, super.paymentMethod});
}

class MyCardsSuccess extends MyCardsState {
  const MyCardsSuccess(
      {required super.cards, required super.selectId, super.paymentMethod});
}

class MyCardsFailure extends MyCardsState {
  final String failure;
  const MyCardsFailure(this.failure,
      {required super.cards, required super.selectId, super.paymentMethod});
}
