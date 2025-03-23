part of 'verify_card_bloc.dart';

abstract class VerifyCardEvent extends Equatable {
  const VerifyCardEvent();

  @override
  List<Object> get props => [];
}

class VerifyCard extends VerifyCardEvent {
  final int cardId;
  final int code;
  const VerifyCard({required this.cardId, required this.code});
}
