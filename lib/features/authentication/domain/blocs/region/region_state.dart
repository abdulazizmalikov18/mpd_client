part of 'region_bloc.dart';

enum RegionOrSearch { initial, region, search }

class RegionState extends Equatable {
  final List<Region> regions;
  final List<Region> searchRegion;
  final bool isEnd, isSearch;
  final String oldQuery;
  final Region? selectedRegion;

  const RegionState(
      {required this.regions,
      this.searchRegion = const [],
      this.isEnd = false,
      this.oldQuery = '',
      required this.selectedRegion,
      this.isSearch = false});

  @override
  List<Object?> get props =>
      [regions, isEnd, oldQuery, isSearch, selectedRegion, searchRegion];
}

class RegionInitial extends RegionState {
  const RegionInitial({required super.regions, required super.selectedRegion});
}

class RegionLoading extends RegionState {
  const RegionLoading(
      {required super.regions,
      super.oldQuery,
      super.isSearch,
      required super.selectedRegion,
      super.isEnd});
}

class RegionSuccess extends RegionState {
  const RegionSuccess(
      {required super.regions,
      super.isEnd,
      super.oldQuery,
      super.isSearch,
      required super.selectedRegion});
}

class RegionFailure extends RegionState {
  final String error;
  const RegionFailure(
      {required super.regions,
      this.error = '',
      super.isEnd,
      required super.selectedRegion});
}
