import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/appoinment_repository.dart';

part 'completed_appointment_event.dart';
part 'completed_appointment_state.dart';

class CompletedAppointmentBloc
    extends Bloc<CompletedAppointmentEvent, CompletedAppointmentState> {
  CompletedAppointmentBloc(this._profileRepository)
      : super(CompletedAppointmentInitial()) {
    on<GetCompletedAppoinmentsEvent>(_onGetAppoinmentsEvent,
        transformer: droppable());
  }

  final AppoinmentRepository _profileRepository;
  final _limit = 10;
  int _offset = 0;

  //get records
  Future<void> _onGetAppoinmentsEvent(GetCompletedAppoinmentsEvent event,
      Emitter<CompletedAppointmentState> emit) async {
    if (state.hasReachedMax && !event.isRefresh) return;

    if (event.isRefresh) _offset = 0;
    if (event.isErrorRefresh) {
      emit(CompletedAppointmentInitial());
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // Here, Getting appointments first time and refreshed all appointments
    if (state is CompletedAppointmentInitial) {
      final result = await _profileRepository
          .getUserAppoinments(PaginationModel(limit: _limit, status: 5));
      if (result.isRight) {
        _offset += 10;
        emit(CompletedAppoinmentSuccess(
            appoinments: result.right.results,
            hasReachedMax: result.right.results.length < _offset));
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting upcoming appointments with pagination
    final result = await _profileRepository.getUserAppoinments(
        PaginationModel(limit: _limit, status: 5, offset: _offset));
    if (result.isRight) {
      _offset += 10;
      final completedAppointments = [
        ...state.appoinments,
        ...result.right.results
      ];
      emit(CompletedAppoinmentSuccess(
          appoinments:
              event.isRefresh ? result.right.results : completedAppointments,
          hasReachedMax: completedAppointments.length < _offset));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<CompletedAppointmentState> emit) {
    if (failure is NetworkFailure) {
      emit(CompletedAppoinmentsFailure(
          appoinments: state.appoinments, failure: failure.errorMessage));
    } else {
      emit(CompletedAppoinmentsFailure(
          appoinments: state.appoinments, failure: 'Server failure'));
    }
  }
}
