import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/yandex_doctor_repository.dart';

part 'search_by_category_event.dart';
part 'search_by_category_state.dart';

class SearchByCategoryBloc extends Bloc<SearchByCategoryEvent, SearchByCategoryState> {
  SearchByCategoryBloc(this._yandexDoctorRepository) : super(const SearchByCategoryInitial([])) {
    on<GetSearchedByCategory>(_onSearchedByCategory, transformer: droppable());
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  final YandexDoctorRepository _yandexDoctorRepository;

  void _onSelectCategory(SelectCategoryEvent event, Emitter<SearchByCategoryState> emit) {
    if (event.id == state.selectedId) return;
    emit(SearchByCategorySuccess(state.specialists, selectedId: event.id, isLoading: true));
  }

  Future<void> _onSearchedByCategory(GetSearchedByCategory event, Emitter<SearchByCategoryState> emit) async {
    // if (state.selectedId == event.id) return;
    emit(SearchByCategoryLoading(state.specialists, selectedId: event.id, isLoading: true, selectedName: event.name));
    final result = await _yandexDoctorRepository.getSpecialistByCategory(id: event.id);
    if (result.isRight) {
      emit(SearchByCategorySuccess(result.right.results!, selectedId: state.selectedId, isLoading: false, selectedName: state.selectedName));
    } else {
      emit(SearchByCategoryFailure(state.specialists, failure: result.left.errorMessage, selectedId: state.selectedId, selectedName: state.selectedName));
    }
  }
}
