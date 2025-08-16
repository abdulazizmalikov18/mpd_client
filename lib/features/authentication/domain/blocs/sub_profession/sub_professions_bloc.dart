import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'sub_professions_event.dart';
part 'sub_professions_state.dart';

class SubProfessionsBloc
    extends Bloc<SubProfessionsEvent, SubProfessionsState> {
  SubProfessionsBloc(this._repository)
    : super(
        const SubProfessionsInitial(
          subProfessions: [],
          selectedSubProfession: null,
        ),
      ) {
    on<GetSubProfessionsEvent>(
      _onGetSubProfessions,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
    on<SelectSubProfessionEvent>(_onSelectSubProfession);
  }

  final AuthRepository _repository;
  final List<Profession> _subProfessions = [];
  final int _limit = 15;
  int _offset = 0;

  void _onSelectSubProfession(
    SelectSubProfessionEvent event,
    Emitter<SubProfessionsState> emit,
  ) {
    emit(
      SubProfessionsLoaded(
        subProfessions: state.subProfessions,
        selectedSubProfession: event.selectedSubProfession,
      ),
    );
  }

  Future<void> _onGetSubProfessions(
    GetSubProfessionsEvent event,
    Emitter<SubProfessionsState> emit,
  ) async {
    if (state.isEnd && state.oldParent == event.parent) return;
    _clearOffset(event, state);
    emit(
      SubProfessionsLoading(
        subProfessions: state.subProfessions,
        oldParent: event.parent,
        selectedSubProfession: state.selectedSubProfession,
      ),
    );

    final result = await _repository.getProfessions(
      limit: _limit,
      offset: _offset,
      parent: event.parent,
    );
    if (result.isRight) {
      _addOffset(result.right);
      emit(
        SubProfessionsLoaded(
          subProfessions: _subProfessions,
          isEnd: _subProfessions.length < _offset,
          oldParent: event.parent,
          selectedSubProfession: state.selectedSubProfession,
        ),
      );
    } else {
      emit(
        SubProfessionsFailure(
          subProfessions: state.subProfessions,
          error: result.left.message,
          selectedSubProfession: state.selectedSubProfession,
        ),
      );
    }
  }

  void _clearOffset(GetSubProfessionsEvent event, SubProfessionsState state) {
    if (state.oldParent != event.parent) {
      _subProfessions.clear();
      _offset = 0;
    }
  }

  void _addOffset(ProfessionModel r) {
    _offset += 15;
    _subProfessions.addAll(r.results!);
  }
}
