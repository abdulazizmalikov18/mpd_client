part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();

  @override
  List<Object> get props => [];
}

class SelectDayEvent extends TimetableEvent {
  final DateTime day;
  final DateTime focusedDay;
  const SelectDayEvent({required this.day, required this.focusedDay});
}

class SelectTimeEvent extends TimetableEvent {
  final String time;
  const SelectTimeEvent({required this.time});
}

class OnChangedCommentEvent extends TimetableEvent {
  final String value;
  const OnChangedCommentEvent({required this.value});
}

class OnChangedCalFormatEvent extends TimetableEvent {
  final CalendarFormat format;
  const OnChangedCalFormatEvent({required this.format});
}

class GetTimetableByDay extends TimetableEvent {
  final int id;
  final DateTime day;
  const GetTimetableByDay({required this.day, required this.id});
}
