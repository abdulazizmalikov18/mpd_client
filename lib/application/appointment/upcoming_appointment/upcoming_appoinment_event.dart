part of 'upcoming_appoinment_bloc.dart';

abstract class UpcomingAppoinmentsEvent extends Equatable {
  const UpcomingAppoinmentsEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingAppoinmentsEvent extends UpcomingAppoinmentsEvent {
  final bool isRefresh;
  final bool isErrorRefresh;
  const GetUpcomingAppoinmentsEvent(
      {this.isRefresh = false, this.isErrorRefresh = false});
}

class DeleteUpcomingAppointment extends UpcomingAppoinmentsEvent {
  final Appointment appointment;
  const DeleteUpcomingAppointment(this.appointment);
}

class ClearUpcomingAppointment extends UpcomingAppoinmentsEvent {}
