import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/popular_categories_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:mpd_client/features/yandex_doctor/data/repositories/yandex_doctor_repository.dart';

part 'specialist_event.dart';
part 'specialist_state.dart';

class SpecialistBloc extends Bloc<SpecialistEvent, SpecialistState> {
  final YandexDoctorRepository _yandexDoctorRepository;
  SpecialistBloc(this._yandexDoctorRepository)
      : super(const SpecialistState()) {
    on<GetSpecialist>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await _yandexDoctorRepository.getSearchedSpecialist(
        query: event.search ?? "",
        jobId: event.jobId,
      );
      if (result.isRight) {
        emit(state.copyWith(
          specialist: result.right.results,
          status: FormzSubmissionStatus.success,
        ));
        if (event.onSucces!=null) {
          event.onSucces!(result.right.results);
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
    on<GetSpecialistCategory>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result =
          await _yandexDoctorRepository.getSpecialistByCategory(id: event.id);
      if (result.isRight) {
        emit(state.copyWith(
          specialist: result.right.results,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetCategory>((event, emit) async {
      if (state.categories.isEmpty || event.isMore) {
        emit(state.copyWith(statusCategory: FormzSubmissionStatus.inProgress));
        final result = await _yandexDoctorRepository.getPopularCategories();
        if (result.isRight) {
          emit(state.copyWith(
            categories: result.right.results,
            statusCategory: FormzSubmissionStatus.success,
          ));
        } else {
          emit(state.copyWith(statusCategory: FormzSubmissionStatus.failure));
        }
      }
    });

    on<SelectingCategory>(
      (event, emit) => emit(
        state.copyWith(
          categoryId: event.id,
          selectedName: event.id == -1
              ? ""
              : state.categories
                  .where((element) => element.id == event.id)
                  .toList()
                  .first
                  .name,
        ),
      ),
    );
  }
}
