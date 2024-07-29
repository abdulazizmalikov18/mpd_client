import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/yandex_doctor_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'filter_category_event.dart';

part 'filter_category_state.dart';

class FilterCategoryBloc extends Bloc<FilterCategoryEvent, FilterCategoryState> {
  FilterCategoryBloc(this._yandexDoctorRepository, this.searchController) : super(FilterCategoryInitial()) {
    on<GetFilterCategories>(_onGetFilterCategories, transformer: droppable());
    on<SelectedCategoryEvent>(_onSelectCategory);
    on<SearchCategoryEvent>(
      _onSearchCategory,
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(milliseconds: 250)).asyncExpand(mapper);
      },
    );
  }

  final YandexDoctorRepository _yandexDoctorRepository;

  final List<PopularCategories> _categories = [];
  final TextEditingController searchController;
  final int _limit = 30;
  int _offset = 0;
  int categoriesCount = 0;

  Future<void> _onGetFilterCategories(GetFilterCategories event, Emitter<FilterCategoryState> emit) async {
    if (state.hasReachedMax) return;

    // Here, Getting professions first time
    if (state is FilterCategoryInitial) {
      final result = await _yandexDoctorRepository.getPopularCategories(limit: _limit, offset: _offset);
      if (result.isRight) {
        _offset += (result.right.count as num? ?? 0).toInt();
        _categories.addAll(result.right.results!);
        categoriesCount = result.right.count!;
        emit(FilterCategorySuccess(categories: result.right.results!, hasReachedMax: result.right.results!.length < _offset));
      } else {
        errorChecker(result.left, emit);
      }
    } else {
      // Here, Getting retailed professions with pagination
      final result = await _yandexDoctorRepository.getPopularCategories(limit: _limit, offset: _offset);
      if (result.isRight) {
        _offset += 30;
        _categories.addAll(result.right.results!);

        emit(FilterCategorySuccess(hasReachedMax: _categories.length < _offset, categories: [..._categories]));
      } else {
        errorChecker(result.left, emit);
      }
    }
  }

  void _onSelectCategory(SelectedCategoryEvent event, Emitter<FilterCategoryState> emit) {
    emit(FilterCategorySuccess(categories: state.categories, hasReachedMax: state.hasReachedMax, selectedCategoryId: event.selectedId, selectedCategoryName: event.selectedName));
  }

  Future<void> _onSearchCategory(SearchCategoryEvent event, Emitter<FilterCategoryState> emit) async {
    if (event.query.length < 4) {
      emit(FilterCategorySuccess(hasReachedMax: _categories.length < _offset, isSearch: false, categories: [..._categories]));
      return;
    }
    emit(FilterCategoryInitial());
    // Here, Searching category
    final result = await _yandexDoctorRepository.getPopularCategories(query: event.query, langCode: event.langCode);
    if (result.isRight) {
      emit(FilterCategorySuccess(categories: result.right.results!, hasReachedMax: true, isSearch: true));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<FilterCategoryState> emit) {
    if (failure is NetworkFailure) {
      emit(FilterCategoryFailure(categories: state.categories, failure: failure.errorMessage));
    } else {
      emit(FilterCategoryFailure(categories: state.categories, failure: 'Server failure'));
    }
  }
}
