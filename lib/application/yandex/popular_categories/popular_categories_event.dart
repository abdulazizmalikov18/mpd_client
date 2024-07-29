part of 'popular_categories_bloc.dart';

abstract class PopularCategoriesEvent extends Equatable {
  const PopularCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularCategoriesEvent extends PopularCategoriesEvent {
  final String langCode;
  const GetPopularCategoriesEvent(this.langCode);
}

class SelectingCategoryEvent extends PopularCategoriesEvent {
  final int id;
  final String job;
  const SelectingCategoryEvent(this.id, this.job);
}
