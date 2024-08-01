part of 'completed_appointment_bloc.dart';

abstract class CompletedAppointmentState extends Equatable {
  final List<Appointment> appoinments;
  final bool hasReachedMax;
  const CompletedAppointmentState(
      {this.appoinments = const [], this.hasReachedMax = false});

  @override
  List<Object> get props => [appoinments, hasReachedMax];
}

class CompletedAppointmentInitial extends CompletedAppointmentState {}

class CompletedAppoinmentSuccess extends CompletedAppointmentState {
  const CompletedAppoinmentSuccess({super.appoinments, super.hasReachedMax});
}

class CompletedAppoinmentsFailure extends CompletedAppointmentState {
  final String failure;
  const CompletedAppoinmentsFailure(
      {super.appoinments, required this.failure, super.hasReachedMax});
}
