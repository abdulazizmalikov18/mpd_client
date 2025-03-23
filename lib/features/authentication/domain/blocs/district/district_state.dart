part of 'district_bloc.dart';

abstract class DistrictState {
  final List<Region> districts;
  final bool isEnd;
  final Region? selectedDistict;
  final int oldParent;
  const DistrictState(
      {required this.districts,
      this.isEnd = false,
      this.oldParent = -1,
      required this.selectedDistict});
}

class DistrictInitial extends DistrictState {
  const DistrictInitial(
      {required super.districts, required super.selectedDistict});
}

class DistrictLoading extends DistrictState {
  const DistrictLoading(
      {required super.districts,
      super.oldParent,
      required super.selectedDistict});
}

class DistrictSuccess extends DistrictState {
  const DistrictSuccess(
      {required super.districts,
      super.isEnd,
      super.oldParent,
      required super.selectedDistict});
}

class DistrictFailure extends DistrictState {
  final String error;
  const DistrictFailure(
      {required super.districts,
      required this.error,
      required super.selectedDistict});
}
