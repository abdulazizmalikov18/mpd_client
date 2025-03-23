import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/appointment/data/models/pagination_model.dart';
import 'package:mpd_client/features/appointment/data/models/appoinment_model.dart';

part 'appoinment_event.dart';
part 'appoinment_state.dart';

class AppoinmentsBloc extends Bloc<AppoinmentsEvent, AppoinmentsState> {
  AppoinmentsBloc(
    this._profileRepository,
  ) : super(const AppoinmentsState()) {
    on<GetAppoinmentsEvent>(_onGetAppoinmentsEvent, transformer: droppable());
    on<GetAppoinmentsCanceledEvent>(
      _onGetAppoinmentsCanceledEvent,
      transformer: droppable(),
    );
    on<GetAppoinmentsCompletedEvent>(
      _onGetAppoinmentsCompletedEvent,
      transformer: droppable(),
    );
    on<DeleteAppointment>(_onDeleteAppointment);
    on<ClearAppointment>(_onClearAppointments);
  }

  final AppoinmentRepository _profileRepository;

  void _onClearAppointments(ClearAppointment event, Emitter emit) {}

  void _onDeleteAppointment(
      DeleteAppointment event, Emitter<AppoinmentsState> emit) {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final appointmentsAfterDelete = state.appoinments;
    appointmentsAfterDelete.remove(event.appointment);
    emit(state.copyWith(
      appoinments: appointmentsAfterDelete,
      status: FormzSubmissionStatus.success,
    ));
  }

  Future<void> _onGetAppoinmentsEvent(
      GetAppoinmentsEvent event, Emitter<AppoinmentsState> emit) async {
    if (event.getMore) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
    final result = await _profileRepository.getUserAppoinments(PaginationModel(
      status: 1,
      offset: event.getMore ? state.appoinments.length : 0,
    ));
    if (result.isRight) {
      emit(state.copyWith(
        appoinments: event.getMore
            ? [
                ...state.appoinments,
                ...result.right.results,
              ]
            : result.right.results,
        count: result.right.count,
        status: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onGetAppoinmentsCompletedEvent(
      GetAppoinmentsCompletedEvent event,
      Emitter<AppoinmentsState> emit) async {
    if (event.getMore) {
      emit(state.copyWith(statusCompleted: FormzSubmissionStatus.inProgress));
    }
    final result = await _profileRepository.getUserAppoinments(PaginationModel(
      status: 5,
      offset: event.getMore ? state.appoinments.length : 0,
    ));
    if (result.isRight) {
      emit(state.copyWith(
        appoinmentsCompleted: event.getMore
            ? [
                ...state.appoinments,
                ...result.right.results,
              ]
            : result.right.results,
        countCompleted: result.right.count,
        statusCompleted: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusCompleted: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onGetAppoinmentsCanceledEvent(
      GetAppoinmentsCanceledEvent event, Emitter<AppoinmentsState> emit) async {
    if (event.getMore) {
      emit(state.copyWith(statusCancel: FormzSubmissionStatus.inProgress));
    }
    final result = await _profileRepository.getUserAppoinments(PaginationModel(
      status: -1,
      offset: event.getMore ? state.appoinments.length : 0,
    ));
    if (result.isRight) {
      emit(state.copyWith(
        appoinmentsCancel: event.getMore
            ? [
                ...state.appoinments,
                ...result.right.results,
              ]
            : result.right.results,
        countCancel: result.right.count,
        statusCancel: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(statusCancel: FormzSubmissionStatus.failure));
    }
  }
}
