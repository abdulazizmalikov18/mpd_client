part of 'completed_appointment_bloc.dart';

abstract class CompletedAppointmentEvent extends Equatable {
  const CompletedAppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetCompletedAppoinmentsEvent extends CompletedAppointmentEvent {
  final bool isRefresh;
  final bool isErrorRefresh;
  const GetCompletedAppoinmentsEvent(
      {this.isRefresh = false, this.isErrorRefresh = false});
}
