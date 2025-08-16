import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'region_event.dart';
part 'region_state.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc(this._repository, this._searchController)
    : super(const RegionInitial(regions: [], selectedRegion: null)) {
    on<GetRegionsEvent>(_onGetRegions);
    // on<GetRegionsFromSearch>(
    //   _onGetFromSearch,
    //   transformer: (events, mapper) {
    //     return events
    //         .debounceTime(const Duration(milliseconds: 250))
    //         .asyncExpand(mapper);
    //   },
    // );
    on<SelectRegionEvent>(_onSelectRegion);
    on<CancelEvent>(_onCancelEvent);
  }

  final AuthRepository _repository;

  final TextEditingController _searchController;
  final List<Region> _regions = [];
  final int _limit = 15;
  int _offset = 0;

  TextEditingController get searchController => _searchController;

  // Choose profession from all professions

  Future<void> _onCancelEvent(
    CancelEvent event,
    Emitter<RegionState> emit,
  ) async {
    _clearFromSearch(state);
  }

  void _onSelectRegion(SelectRegionEvent event, Emitter<RegionState> emit) {
    emit(
      RegionSuccess(
        regions: state.regions,
        selectedRegion: event.selectedRegion,
      ),
    );
  }

  // Get all professions from api
  Future<void> _onGetRegions(
    GetRegionsEvent event,
    Emitter<RegionState> emit,
  ) async {
    if (state.isEnd && !state.isSearch) return;
    emit(
      RegionLoading(
        regions: state.regions,
        isSearch: false,
        selectedRegion: state.selectedRegion,
      ),
    );
    final result = await _repository.getRegions(limit: _limit, offset: _offset);
    if (result.isRight) {
      _addOffset(result.right);
      emit(
        RegionSuccess(
          regions: _regions,
          isEnd: _regions.length < _offset,
          selectedRegion: state.selectedRegion,
        ),
      );
    } else {
      emit(
        RegionFailure(
          regions: state.regions,
          error: result.left.message,
          selectedRegion: state.selectedRegion,
        ),
      );
    }
  }

  // // Get regions from searched api
  // Future<void> _onGetFromSearch(
  //     GetRegionsFromSearch event, Emitter<RegionState> emit) async {
  //   if (event.query.length <= 1) return;
  //   _searchNewQuery(event, state);
  //   emit(RegionLoading(
  //       regions: _regions,
  //       oldQuery: event.query,
  //       isSearch: true,
  //       selectedRegion: state.selectedRegion));
  //   final result = await _repository.getRegions(
  //       limit: _limit, offset: _offset, query: event.query);
  //   result.fold((failure) {
  //     if (failure is NetworkFailure) {
  //       emit(RegionFailure(
  //           regions: state.regions,
  //           error: failure.message,
  //           selectedRegion: state.selectedRegion));
  //     } else if (failure is ServerTimeOutFailure) {
  //       emit(RegionFailure(
  //           regions: state.regions,
  //           error: failure.message,
  //           selectedRegion: state.selectedRegion));
  //     } else if (failure is ServerNotFoundFailure) {
  //       emit(RegionFailure(
  //           regions: state.regions,
  //           error: failure.message.replaceAll('[', '').replaceAll(']', ''),
  //           selectedRegion: state.selectedRegion));
  //     } else {
  //       emit(RegionFailure(
  //           regions: state.regions,
  //           error: failure.message,
  //           selectedRegion: state.selectedRegion));
  //     }
  //   }, (r) {
  //     _addOffset(r);
  //     emit(RegionSuccess(
  //         regions: _regions,
  //         isEnd: _regions.length < _offset,
  //         isSearch: true,
  //         selectedRegion: state.selectedRegion,
  //         oldQuery: event.query));
  //   });
  // }

  void _clearFromSearch(RegionState state) {
    if (!state.isSearch) {
      _searchController.clear();
      // _regions.clear();

      // _offset = 0;
    }
  }

  void _addOffset(RegionsModel r) {
    _offset += 15;
    _regions.addAll(r.results!);
  }

  // void _searchNewQuery(GetRegionsFromSearch event, RegionState state) {
  //   if (state.oldQuery != event.query) {
  //     _regions.clear();
  //     _offset = 0;
  //   }
  // }
}
