import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/user_repository.dart';

part 'records_event.dart';

part 'records_state.dart';

class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  RecordsBloc(this._profileRepository, this._searchController) : super(const RecordsState()) {
    on<GetRecordsEvent>(_onGetRecordsEvent);
    on<SearchRecordEvent>(_onSearchRecords);
    on<CancelSearchEvent>(_onCancelSearchEvent);
  }

  final UserRepository _profileRepository;
  final TextEditingController _searchController;

  TextEditingController get searchController => _searchController;
  final List<RecordModel> _records = [];
  final _limit = 10;
  int _offset = 0;

//camcel search
  Future<void> _onCancelSearchEvent(CancelSearchEvent event, Emitter<RecordsState> emit) async {
    // _clearFromSearch(state);
  }

  //get records
  Future<void> _onGetRecordsEvent(GetRecordsEvent event, Emitter<RecordsState> emit) async {
    if (state.hasReachedMax && !event.isRefresh) return;

    if (event.isRefresh) _offset = 0;

    // Here, Getting professions first time
    if (state.status.isInitial) {
      final result = await _profileRepository.getUserRecords(limit: _limit, offset: _offset);
      if (result.isRight) {
        _offset += 10;
        _records.addAll(result.right.results!);
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          records: result.right.results!,
          hasReachedMax: result.right.results!.length < _offset,
        ));
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting retailed professions with pagination
    final result = await _profileRepository.getUserRecords(limit: _limit, offset: event.isRefresh ? 0 : _offset);
    if (result.isRight) {
      if (event.isRefresh) {
        _offset = 0;
        _records.clear();
      }
      _offset += 10;
      _records.addAll(result.right.results!);

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        hasReachedMax: _records.length < _offset,
        records: [..._records],
      ));
    } else {
      errorChecker(result.left, emit);
    }
  }

  Future<void> _onSearchRecords(SearchRecordEvent event, Emitter<RecordsState> emit) async {
    if (event.query.length < 3) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          hasReachedMax: _records.length < _offset,
          isSearch: false,
          records: [..._records],
        ),
      );
      return;
    }
    if (state.hasReachedMax) {
      final searchingResult = _records.where((element) => element.product!.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        records: searchingResult,
        hasReachedMax: _records.length < _offset,
        isSearch: true,
      ));
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    // Here, Getting records with searching event
    final result = await _profileRepository.getUserRecords(query: event.query);
    if (result.isRight) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        records: result.right.results!,
        hasReachedMax: true,
        isSearch: true,
      ));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<RecordsState> emit) {
    if (failure is NetworkFailure) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, records: state.records, failure: failure.errorMessage));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure, records: state.records, failure: 'Server failure'));
    }
  }
}
