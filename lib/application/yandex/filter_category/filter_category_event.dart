part of 'filter_category_bloc.dart';

abstract class FilterCategoryEvent extends Equatable {
  const FilterCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetFilterCategories extends FilterCategoryEvent {
  final String langCode;
  const GetFilterCategories(this.langCode);
}

class SelectedCategoryEvent extends FilterCategoryEvent {
  final int selectedId;
  final String selectedName;
  const SelectedCategoryEvent(this.selectedId, this.selectedName);
}

class SearchCategoryEvent extends FilterCategoryEvent {
  final String query;
  final String langCode;
  const SearchCategoryEvent(this.query, this.langCode);
}
