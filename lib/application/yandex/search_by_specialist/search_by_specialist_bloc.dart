import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/yandex_doctor_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'search_by_specialist_event.dart';
part 'search_by_specialist_state.dart';

class SearchBySpecialistBloc extends Bloc<SearchBySpecialistEvent, SearchBySpecialistState> {
  SearchBySpecialistBloc(this._yandexDoctorRepository, this._focusNode) : super(const SearchBySpecialistInitial([])) {
    on<SearchedSpecialistEvent>(
      _onSearchedSpecialist,
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(milliseconds: 200)).asyncExpand(mapper);
      },
    );
    on<CloseSuggessionsEvent>(_onCloseSuggestions);
    on<StopSearchingEvent>(_onStopSearching);
    on<FocusedSearchingEvent>(_onFocusedSearch);
  }

  final YandexDoctorRepository _yandexDoctorRepository;
  final FocusNode _focusNode;

  FocusNode get focusnode => _focusNode;

  void _onCloseSuggestions(CloseSuggessionsEvent event, Emitter<SearchBySpecialistState> emit) {
    _focusNode.unfocus();
    emit(SearchBySpecialistInitial(state.searchedSpecialists));
  }

  void _onStopSearching(StopSearchingEvent event, Emitter<SearchBySpecialistState> emit) {
    emit(SearchBySpecialistInitial(state.searchedSpecialists));
  }

  void _onFocusedSearch(FocusedSearchingEvent event, Emitter<SearchBySpecialistState> emit) {
    emit(SearchBySpecialistSuccess(state.searchedSpecialists));
  }

  Future<void> _onSearchedSpecialist(SearchedSpecialistEvent event, Emitter<SearchBySpecialistState> emit) async {
    if (event.query.isEmpty || event.query.length < 3) return;
    emit(SearchBySpecialistLoading(state.searchedSpecialists));
    final result = await _yandexDoctorRepository.getSearchedSpecialist(query: event.query);
    if (result.isRight) {
      emit(SearchBySpecialistSuccess(result.right.results!));
    } else {
      emit(SearchBySpecialistFailure(state.searchedSpecialists, failure: result.left.errorMessage));
    }
  }
}
