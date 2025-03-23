part of 'appoinment_bloc.dart';

abstract class AppoinmentsEvent extends Equatable {
  const AppoinmentsEvent();

  @override
  List<Object> get props => [];
}

class GetAppoinmentsEvent extends AppoinmentsEvent {
  final bool getMore;
  const GetAppoinmentsEvent({this.getMore = false});
}

class GetAppoinmentsCompletedEvent extends AppoinmentsEvent {
  final bool getMore;
  const GetAppoinmentsCompletedEvent({this.getMore = false});
}

class GetAppoinmentsCanceledEvent extends AppoinmentsEvent {
  final bool getMore;
  const GetAppoinmentsCanceledEvent({this.getMore = false});
}

class DeleteAppointment extends AppoinmentsEvent {
  final Appointment appointment;
  const DeleteAppointment(this.appointment);
}

class ClearAppointment extends AppoinmentsEvent {}
