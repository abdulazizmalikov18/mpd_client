import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/appoinment_repository.dart';

part 'canceled_appointment_event.dart';
part 'canceled_appointment_state.dart';

class CanceledAppointmentBloc extends Bloc<CanceledAppointmentEvent, CanceledAppointmentState> {
  CanceledAppointmentBloc(this._profileRepository) : super(CanceledAppointmentInitial()) {
    on<GetCanceledAppoinmentsEvent>(_onGetAppoinmentsEvent, transformer: droppable());
  }

  final AppoinmentRepository _profileRepository;
  final _limit = 10;
  int _offset = 0;

  //get records
  Future<void> _onGetAppoinmentsEvent(GetCanceledAppoinmentsEvent event, Emitter<CanceledAppointmentState> emit) async {
    if (state.hasReachedMax && !event.isRefresh) return;

    if (event.isRefresh) _offset = 0;

    if (event.isErrorRefresh) {
      emit(CanceledAppointmentInitial());
      await Future.delayed(const Duration(milliseconds: 500));
    }

    debugPrint("-------------------Cancel refresh----------------------");

    // Here, Getting appointments first time and refreshed all appointments
    if (state is CanceledAppointmentInitial) {
      final result = await _profileRepository.getUserAppoinments(PaginationModel(limit: _limit, status: -1));
      if (result.isRight) {
        _offset += 10;
        emit(CanceledAppoinmentSuccess(
          appoinments: result.right.results,
          hasReachedMax: result.right.results.length > _offset,
        ));
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting upcoming appointments with pagination
    final result = await _profileRepository.getUserAppoinments(
      PaginationModel(
        limit: _limit,
        status: -1,
        offset: _offset,
      ),
    );
    if (result.isRight) {
      _offset += 10;
      final canceledAppointments = [...state.appoinments, ...result.right.results];
      emit(CanceledAppoinmentSuccess(appoinments: event.isRefresh ? result.right.results : canceledAppointments, hasReachedMax: canceledAppointments.length < _offset));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<CanceledAppointmentState> emit) {
    if (failure is NetworkFailure) {
      emit(CanceledAppoinmentsFailure(appoinments: state.appoinments, failure: failure.errorMessage));
    } else {
      emit(CanceledAppoinmentsFailure(appoinments: state.appoinments, failure: 'Server failure'));
    }
  }
}
