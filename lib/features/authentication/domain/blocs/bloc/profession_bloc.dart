import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:rxdart/transformers.dart';

part 'profession_event.dart';
part 'profession_state.dart';

class ProfessionBloc extends Bloc<ProfessionEvent, ProfessionState> {
  ProfessionBloc(this._authRepository, this.searchController)
    : super(ProfessionInitial()) {
    on<GetProfessionEvent>(_onGetProfessionsEvent, transformer: droppable());
    on<ChooseProfessionEvent>(_onChooseProfession);
    on<SearchProfessionsEvent>(
      _onSearchProfessions,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  final AuthRepository _authRepository;
  final _limit = 15;
  int _offset = 0;
  final professions = <Profession>[];
  final TextEditingController searchController;

  Future<void> _onGetProfessionsEvent(
    GetProfessionEvent event,
    Emitter<ProfessionState> emit,
  ) async {
    if (state.hasReachedMax) return;

    // Here, Getting professions first time
    if (state is ProfessionInitial) {
      final result = await _authRepository.getProfessions(
        limit: _limit,
        offset: _offset,
      );
      if (result.isRight) {
        _offset += 15;
        professions.addAll(result.right.results!);
        emit(
          ProfessionSuccess(
            professions: result.right.results!,
            hasReachedMax: result.right.results!.length < _offset,
          ),
        );
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting retailed professions with pagination
    final result = await _authRepository.getProfessions(
      limit: _limit,
      offset: _offset,
    );
    if (result.isRight) {
      _offset += 15;
      professions.addAll(result.right.results!);

      emit(
        ProfessionSuccess(
          hasReachedMax: professions.length < _offset,
          professions: professions,
        ),
      );
    } else {
      errorChecker(result.left, emit);
    }
  }

  Future<void> _onSearchProfessions(
    SearchProfessionsEvent event,
    Emitter<ProfessionState> emit,
  ) async {
    if (event.query.length < 3) {
      emit(
        ProfessionSuccess(
          hasReachedMax: professions.length < _offset,
          professions: [...professions],
        ),
      );
      return;
    }
    emit(ProfessionInitial());
    // Here, Getting professions first time
    final result = await _authRepository.getProfessions(query: event.query);
    if (result.isRight) {
      emit(
        ProfessionSuccess(
          professions: result.right.results!,
          hasReachedMax: result.right.results!.length < _offset,
        ),
      );
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<ProfessionState> emit) {
    if (failure is NetworkFailure) {
      emit(
        ProfessionFailure(
          professions: state.professions,
          failure: failure.message,
        ),
      );
    } else {
      emit(
        ProfessionFailure(
          professions: state.professions,
          failure: 'Server failure',
        ),
      );
    }
  }

  void _onChooseProfession(
    ChooseProfessionEvent event,
    Emitter<ProfessionState> emit,
  ) => emit(ProfessionSuccess(chosenProfession: event.profession));
}
