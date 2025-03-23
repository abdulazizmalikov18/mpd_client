import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  DistrictBloc(this._repository)
      : super(const DistrictInitial(districts: [], selectedDistict: null)) {
    on<GetDistrictsEvent>(
      _onGetDistricts,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
    on<SelectDistrictEvent>(_onSelectDistrict);
  }

  final AuthRepository _repository;
  final List<Region> _districts = [];
  final int _limit = 15;
  int _offset = 0;

  void _onSelectDistrict(
      SelectDistrictEvent event, Emitter<DistrictState> emit) {
    emit(DistrictInitial(
        districts: state.districts, selectedDistict: event.selectedDistrict));
  }

  Future<void> _onGetDistricts(
      GetDistrictsEvent event, Emitter<DistrictState> emit) async {
    if (state.isEnd && state.oldParent == event.parent) return;
    // if (state is DistrictLoading) return;

    _clearOffset(event, state);
    emit(DistrictLoading(
        districts: state.districts,
        oldParent: event.parent,
        selectedDistict: state.selectedDistict));

    final result = await _repository.getRegions(
        limit: _limit, offset: _offset, parent: event.parent);
    if (result.isRight) {
      _addOffset(result.right);
      emit(DistrictSuccess(
          districts: _districts,
          isEnd: _districts.length < _offset,
          oldParent: state.oldParent,
          selectedDistict: state.selectedDistict));
    } else {
      emit(DistrictFailure(
          districts: state.districts,
          error: result.left.message,
          selectedDistict: state.selectedDistict));
    }
  }

  void _clearOffset(GetDistrictsEvent event, DistrictState state) {
    if (state.oldParent != event.parent) {
      _districts.clear();
      _offset = 0;
    }
  }

  void _addOffset(RegionsModel r) {
    _offset += 15;
    _districts.addAll(r.results!);
  }
}
