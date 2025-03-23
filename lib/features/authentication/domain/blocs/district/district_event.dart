part of 'district_bloc.dart';

abstract class DistrictEvent extends Equatable {
  const DistrictEvent();

  @override
  List<Object> get props => [];
}

class GetDistrictsEvent extends DistrictEvent {
  final int parent;
  const GetDistrictsEvent({required this.parent});
}

class SelectDistrictEvent extends DistrictEvent {
  final Region selectedDistrict;
  const SelectDistrictEvent({required this.selectedDistrict});
}
