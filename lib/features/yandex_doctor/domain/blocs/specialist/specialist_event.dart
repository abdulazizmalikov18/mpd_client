part of 'specialist_bloc.dart';

sealed class SpecialistEvent {}

class GetSpecialist extends SpecialistEvent {
  final String? search;
  final int? jobId;
  final Function(List<MapSpecialist>? specialist)? onSucces;

  GetSpecialist({
    this.search,
    this.jobId,
    this.onSucces,
  });
}

class GetSpecialistCategory extends SpecialistEvent {
  final int id;

  GetSpecialistCategory(this.id);
}

class GetCategory extends SpecialistEvent {
  final bool isMore;

  GetCategory({this.isMore = false});
}

class SelectingCategory extends SpecialistEvent {
  final int id;

  SelectingCategory(this.id);
}
