import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:mpd_client/domain/models/yandex/popular_categories_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/yandex_doctor_repository.dart';

part 'popular_categories_event.dart';
part 'popular_categories_state.dart';

class PopularCategoriesBloc extends Bloc<PopularCategoriesEvent, PopularCategoriesState> {
  PopularCategoriesBloc(this._yandexDoctorRepository) : super(const PopularCategoriesInitial(popularCategories: [])) {
    on<GetPopularCategoriesEvent>(_onGetPopularCategories, transformer: droppable());
    on<SelectingCategoryEvent>(_onSelectedCategory);
  }

  final YandexDoctorRepository _yandexDoctorRepository;

  final List<PopularCategories> _popularCategories = [];
  final int _limit = 20;
  int _offset = 0;

  void _onSelectedCategory(SelectingCategoryEvent event, Emitter<PopularCategoriesState> emit) {
    emit(PopularCategoriesSuccess(popularCategories: state.popularCategories, isEnd: state.isEnd, selectedId: event.id));
  }

  Future<void> _onGetPopularCategories(GetPopularCategoriesEvent event, Emitter<PopularCategoriesState> emit) async {
    if (state.isEnd) return;
    emit(PopularCategoriesLoading(popularCategories: state.popularCategories));
    final result = await _yandexDoctorRepository.getPopularCategories(limit: _limit, offset: _offset, langCode: event.langCode);
    if (result.isRight) {
      _addOffset(result.right);
      emit(PopularCategoriesSuccess(popularCategories: _popularCategories, isEnd: _popularCategories.length < _offset));
    } else {
      if (result.left is NetworkFailure) {
        emit(PopularCategoriesFailure(popularCategories: state.popularCategories, failure:  const NetworkFailure(errorMessage: 'Please, check your internet connection!')));
      } else {
        emit(PopularCategoriesFailure(popularCategories: state.popularCategories, failure: const ServerFailure(errorMessage: 'Unkown temporary failure, try again later!', statusCode: 0000)));
      }
    }
  }

  void _addOffset(PopularCategoriesModel r) {
    _offset += 20;
    _popularCategories.addAll(r.results!);
  }
}
