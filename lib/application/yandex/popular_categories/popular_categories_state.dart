part of 'popular_categories_bloc.dart';

abstract class PopularCategoriesState extends Equatable {
  final List<PopularCategories> popularCategories;
  final bool isEnd;
  const PopularCategoriesState(
      {required this.popularCategories, this.isEnd = false});

  @override
  List<Object> get props => [popularCategories, isEnd];
}

class PopularCategoriesInitial extends PopularCategoriesState {
  const PopularCategoriesInitial(
      {required super.popularCategories, super.isEnd});
}

class PopularCategoriesLoading extends PopularCategoriesState {
  const PopularCategoriesLoading(
      {required super.popularCategories, super.isEnd});
}

class PopularCategoriesSuccess extends PopularCategoriesState {
  final int selectedId;
  const PopularCategoriesSuccess(
      {required super.popularCategories, super.isEnd, this.selectedId = -1});
}

class PopularCategoriesFailure extends PopularCategoriesState {
  final Failure? failure;
  PopularCategoriesFailure(
      {required super.popularCategories, this.failure, super.isEnd}) {
    debugPrint(
        "Popular Categories error ------------------------- ${failure!.errorMessage}");
    return;
  }
}
