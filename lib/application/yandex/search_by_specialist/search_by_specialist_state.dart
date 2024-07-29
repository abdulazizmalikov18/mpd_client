part of 'search_by_specialist_bloc.dart';

abstract class SearchBySpecialistState extends Equatable {
  final List<MapSpecialist> searchedSpecialists;
  const SearchBySpecialistState(this.searchedSpecialists);

  @override
  List<Object?> get props => [searchedSpecialists];
}

class SearchBySpecialistInitial extends SearchBySpecialistState {
  const SearchBySpecialistInitial(super.searchedSpecialists);
}

class SearchBySpecialistLoading extends SearchBySpecialistState {
  const SearchBySpecialistLoading(super.searchedSpecialists);
}

class SearchBySpecialistSuccess extends SearchBySpecialistState {
  const SearchBySpecialistSuccess(super.searchedSpecialists);
}

class SearchBySpecialistFailure extends SearchBySpecialistState {
  final String failure;
  const SearchBySpecialistFailure(super.searchedSpecialists,
      {required this.failure});
}
