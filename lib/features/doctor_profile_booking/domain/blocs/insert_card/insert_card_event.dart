part of 'insert_card_bloc.dart';

abstract class InsertCardEvent extends Equatable {
  const InsertCardEvent();

  @override
  List<Object> get props => [];
}


class InsertCard extends InsertCardEvent{}
