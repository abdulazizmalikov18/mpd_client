part of 'timetable_bloc.dart';

class TimetableState extends Equatable {
  final TimetableByDateModel? specTimetable;
  final int specialistId;
  final DateTime? datetime;
  final String selectedTime;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final String comment;

  final String failure;
  final Status status;
  const TimetableState(
      {required this.specTimetable,
      required this.datetime,
      required this.focusedDay,
      this.specialistId = -1,
      this.selectedTime = '',
      this.calendarFormat = CalendarFormat.week,
      this.comment = '',
      this.status = Status.initial,
      this.failure = ''});

  TimetableState copyWith(
          {required TimetableByDateModel? specTimetable,
          required DateTime? datetime,
          final int? specialistId,
          final String? selectedTime,
          required DateTime? focusedDay,
          final CalendarFormat? calendarFormat,
          final String? comment,
          final Status? status,
          final String? failure}) =>
      TimetableState(
          specialistId: specialistId ?? this.specialistId,
          specTimetable: specTimetable ?? this.specTimetable,
          datetime: datetime ?? this.datetime,
          selectedTime: selectedTime ?? this.selectedTime,
          focusedDay: focusedDay ?? this.focusedDay,
          calendarFormat: calendarFormat ?? this.calendarFormat,
          comment: comment ?? this.comment,
          status: status ?? this.status,
          failure: failure ?? this.failure);

  @override
  List<Object?> get props => [
        specialistId,
        specTimetable,
        datetime,
        selectedTime,
        focusedDay,
        comment,
        calendarFormat,
        status,
        failure
      ];
}
