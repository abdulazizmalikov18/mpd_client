part of 'specialist_bloc.dart';

class SpecialistState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusCategory;
  final List<MapSpecialist> specialist;
  final List<PopularCategories> categories;
  final int categoryId;
  final String selectedName;

  const SpecialistState({
    this.status = FormzSubmissionStatus.initial,
    this.statusCategory = FormzSubmissionStatus.initial,
    this.specialist = const [],
    this.categories = const [],
    this.categoryId = -1,
    this.selectedName = "",
  });

  SpecialistState copyWith({
    List<MapSpecialist>? specialist,
    FormzSubmissionStatus? status,
    List<PopularCategories>? categories,
    FormzSubmissionStatus? statusCategory,
    int? categoryId,
    String? selectedName,
  }) =>
      SpecialistState(
        specialist: specialist ?? this.specialist,
        status: status ?? this.status,
        categories: categories ?? this.categories,
        statusCategory: statusCategory ?? this.statusCategory,
        categoryId: categoryId ?? this.categoryId,
        selectedName: selectedName ?? this.selectedName,
      );

  @override
  List<Object> get props => [
        status,
        specialist,
        categories,
        statusCategory,
        categoryId,
        selectedName,
      ];
}
