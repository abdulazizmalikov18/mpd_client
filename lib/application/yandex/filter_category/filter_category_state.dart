part of 'filter_category_bloc.dart';

abstract class FilterCategoryState extends Equatable {
  final List<PopularCategories> categories;
  final bool hasReachedMax;
  final bool isSearch;
  final int selectedCategoryId;
  final String selectedCategoryName;
  const FilterCategoryState(
      {this.categories = const [],
      this.hasReachedMax = false,
      this.isSearch = false,
      this.selectedCategoryId = -1,
      this.selectedCategoryName = ''});

  @override
  List<Object> get props => [
        categories,
        hasReachedMax,
        isSearch,
        selectedCategoryId,
        selectedCategoryName
      ];
}

class FilterCategoryInitial extends FilterCategoryState {}

class FilterCategorySuccess extends FilterCategoryState {
  const FilterCategorySuccess(
      {required super.categories,
      super.hasReachedMax,
      super.isSearch,
      super.selectedCategoryId,
      super.selectedCategoryName});
}

class FilterCategoryFailure extends FilterCategoryState {
  final String failure;
  const FilterCategoryFailure(
      {required this.failure, super.categories, super.hasReachedMax});
}
