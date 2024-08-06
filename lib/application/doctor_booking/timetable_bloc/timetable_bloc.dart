import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/domain/models/doctor_booking/timetable_by_day.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';
part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  TimetableBloc(this._repository) : super(TimetableState(specTimetable: null, datetime: DateTime.now(), focusedDay: DateTime.now())) {
    on<SelectDayEvent>(_onSelectDay);
    on<SelectTimeEvent>(_onSelectTime);

    on<OnChangedCommentEvent>(_onChangedComment);
    on<OnChangedCalFormatEvent>(_onChangedCalFormat);
    on<GetTimetableByDay>(_onTimetablePressed, transformer: restartable());
  }

  final DoctorProfileRepository _repository;
  String oldSelectedDate = '';

  void _onSelectDay(SelectDayEvent event, Emitter<TimetableState> emit) {
    emit(state.copyWith(status: Status.initial, datetime: event.day, specTimetable: state.specTimetable, comment: state.comment, focusedDay: event.day, calendarFormat: state.calendarFormat));
  }

  void _onSelectTime(SelectTimeEvent event, Emitter<TimetableState> emit) {
    emit(state.copyWith(
        selectedTime: event.time, datetime: state.datetime, specTimetable: state.specTimetable, comment: state.comment, focusedDay: state.focusedDay, calendarFormat: state.calendarFormat));
  }

  void _onChangedComment(OnChangedCommentEvent event, Emitter<TimetableState> emit) {
    emit(state.copyWith(datetime: state.datetime, specTimetable: state.specTimetable, focusedDay: state.focusedDay, comment: event.value, calendarFormat: state.calendarFormat));
  }

  void _onChangedCalFormat(OnChangedCalFormatEvent event, Emitter<TimetableState> emit) {
    if (event.format == state.calendarFormat) return;
    emit(state.copyWith(datetime: state.datetime, specTimetable: state.specTimetable, focusedDay: state.focusedDay, comment: state.comment, calendarFormat: event.format));
  }

  Future<void> _onTimetablePressed(GetTimetableByDay event, Emitter<TimetableState> emit) async {
    final formattedMonth = Utils.weekDayFormat(event.day);

    emit(state.copyWith(specTimetable: state.specTimetable, datetime: state.datetime, focusedDay: state.focusedDay, selectedTime: '', specialistId: event.id, status: Status.loading));

    final result = await _repository.getTimetable(date: formattedMonth, id: event.id);
    if (result.isRight) {
      emit(state.copyWith(specTimetable: result.right, datetime: state.datetime, focusedDay: state.focusedDay, specialistId: event.id, status: Status.success));
    } else {
      emit(state.copyWith(specTimetable: null, failure: result.left.errorMessage, datetime: state.datetime, specialistId: event.id, focusedDay: state.focusedDay, status: Status.failure));
    }
  }
}
