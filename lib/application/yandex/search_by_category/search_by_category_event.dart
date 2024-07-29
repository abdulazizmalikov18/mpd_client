part of 'search_by_category_bloc.dart';

abstract class SearchByCategoryEvent extends Equatable {
  const SearchByCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetSearchedByCategory extends SearchByCategoryEvent {
  final int id;
  final String name;
  const GetSearchedByCategory(this.id, this.name);
}

class SelectCategoryEvent extends SearchByCategoryEvent {
  final int id;
  const SelectCategoryEvent(this.id);
}
