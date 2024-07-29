part of 'search_by_category_bloc.dart';

abstract class SearchByCategoryState extends Equatable {
  final List<MapSpecialist> specialists;
  final int selectedId;
  final String selectedName;
  final bool isLoading;
  const SearchByCategoryState(this.specialists,
      {this.selectedId = -1, this.isLoading = false, this.selectedName = ''});

  @override
  List<Object> get props => [specialists, selectedId, isLoading, selectedName];
}

class SearchByCategoryInitial extends SearchByCategoryState {
  const SearchByCategoryInitial(super.specialists,
      {super.selectedId, super.isLoading, super.selectedName});
}

class SearchByCategoryLoading extends SearchByCategoryState {
  const SearchByCategoryLoading(super.specialists,
      {super.selectedId, super.isLoading, super.selectedName});
}

class SearchByCategorySuccess extends SearchByCategoryState {
  const SearchByCategorySuccess(super.specialists,
      {super.selectedId, super.isLoading, super.selectedName});
}

class SearchByCategoryFailure extends SearchByCategoryState {
  final String failure;
  const SearchByCategoryFailure(super.specialists,
      {required this.failure, super.selectedId, super.isLoading, super.selectedName});
}
