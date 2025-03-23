part of 'region_bloc.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();

  @override
  List<Object> get props => [];
}

class GetRegionsEvent extends RegionEvent {}

class GetRegionsFromSearch extends RegionEvent {
  final String query;
  const GetRegionsFromSearch({required this.query});
}

class SelectRegionEvent extends RegionEvent {
  final Region? selectedRegion;
  const SelectRegionEvent({required this.selectedRegion});
}

class CancelEvent extends RegionEvent {}
