part of 'canceled_appointment_bloc.dart';

abstract class CanceledAppointmentEvent extends Equatable {
  const CanceledAppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetCanceledAppoinmentsEvent extends CanceledAppointmentEvent {
  final bool isRefresh;
  final bool isErrorRefresh;
  const GetCanceledAppoinmentsEvent(
      {this.isRefresh = false, this.isErrorRefresh = false});
}
