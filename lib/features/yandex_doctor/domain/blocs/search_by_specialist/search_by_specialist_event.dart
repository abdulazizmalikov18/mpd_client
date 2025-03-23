part of 'search_by_specialist_bloc.dart';

abstract class SearchBySpecialistEvent extends Equatable {
  const SearchBySpecialistEvent();

  @override
  List<Object> get props => [];
}

class SearchedSpecialistEvent extends SearchBySpecialistEvent {
  final String query;
  const SearchedSpecialistEvent(this.query);
}

class CloseSuggessionsEvent extends SearchBySpecialistEvent {}

class StopSearchingEvent extends SearchBySpecialistEvent {}

class FocusedSearchingEvent extends SearchBySpecialistEvent {}
