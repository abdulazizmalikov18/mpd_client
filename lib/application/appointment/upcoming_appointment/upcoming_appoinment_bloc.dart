import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/appointment/appoinment_model.dart';
import 'package:mpd_client/domain/models/appointment/pagination_model.dart';
import 'package:mpd_client/infrastructure/core/failures.dart';
import 'package:mpd_client/infrastructure/reopsitories/appoinment_repository.dart';

part 'upcoming_appoinment_event.dart';
part 'upcoming_appoinment_state.dart';

class UpcomingAppoinmentsBloc extends Bloc<UpcomingAppoinmentsEvent, UpcomingAppoinmentsState> {
  UpcomingAppoinmentsBloc(
    this._profileRepository,
  ) : super(UpcomingAppoinmentsInitial()) {
    on<GetUpcomingAppoinmentsEvent>(_onGetAppoinmentsEvent, transformer: droppable());
    on<DeleteUpcomingAppointment>(_onDeleteAppointment);
    on<ClearUpcomingAppointment>(_onClearAppointments);
  }

  final AppoinmentRepository _profileRepository;
  final _limit = 10;
  int _offset = 0;

  void _onClearAppointments(ClearUpcomingAppointment event, Emitter emit) {}

  void _onDeleteAppointment(DeleteUpcomingAppointment event, Emitter<UpcomingAppoinmentsState> emit) {
    final appointmentsAfterDelete = state.appoinments;
    appointmentsAfterDelete.remove(event.appointment);
    emit(UpcomingAppoinmentsSuccess(appoinments: appointmentsAfterDelete, hasReachedMax: state.hasReachedMax));
  }

  // Get Upcoming appointments
  Future<void> _onGetAppoinmentsEvent(GetUpcomingAppoinmentsEvent event, Emitter<UpcomingAppoinmentsState> emit) async {
    if (state.hasReachedMax && !event.isRefresh) return;

    if (event.isRefresh) _offset = 0;

    if (event.isErrorRefresh) {
      emit(UpcomingAppoinmentsInitial());
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // Here, Getting appointments first time and refreshed all appointments
    if (state is UpcomingAppoinmentsInitial) {
      final result = await _profileRepository.getUserAppoinments(PaginationModel(limit: _limit, status: 1));
      if (result.isRight) {
        _offset += 10;
        emit(UpcomingAppoinmentsSuccess(appoinments: result.right.results, hasReachedMax: result.right.results.length < _offset));
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting upcoming appointments with pagination
    final result = await _profileRepository.getUserAppoinments(PaginationModel(limit: _limit, status: 1, offset: _offset));

    if (result.isRight) {
      _offset += 10;
      final upcomingAppointments = [...state.appoinments, ...result.right.results];
      emit(UpcomingAppoinmentsSuccess(appoinments: event.isRefresh ? result.right.results : upcomingAppointments, hasReachedMax: upcomingAppointments.length < _offset));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<UpcomingAppoinmentsState> emit) {
    if (failure is NetworkFailure) {
      emit(UpcomingAppoinmentsFailure(appoinments: state.appoinments, failure: failure.errorMessage));
    } else {
      emit(UpcomingAppoinmentsFailure(appoinments: state.appoinments, failure: 'Server failure'));
    }
  }
}
