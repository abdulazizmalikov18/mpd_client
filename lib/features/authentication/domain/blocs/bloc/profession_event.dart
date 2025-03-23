part of 'profession_bloc.dart';

abstract class ProfessionEvent extends Equatable {
  const ProfessionEvent();

  @override
  List<Object> get props => [];
}

class GetProfessionEvent extends ProfessionEvent {}

class SearchProfessionsEvent extends ProfessionEvent {
  final String query;
  const SearchProfessionsEvent(this.query);
}

class ChooseProfessionEvent extends ProfessionEvent {
  final Profession profession;
  const ChooseProfessionEvent(this.profession);
}
