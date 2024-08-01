part of 'canceled_appointment_bloc.dart';

abstract class CanceledAppointmentState extends Equatable {
  final List<Appointment> appoinments;
  final bool hasReachedMax;
  const CanceledAppointmentState(
      {this.appoinments = const [], this.hasReachedMax = false});

  @override
  List<Object> get props => [appoinments, hasReachedMax];
}

class CanceledAppointmentInitial extends CanceledAppointmentState {}

class CanceledAppoinmentSuccess extends CanceledAppointmentState {
  const CanceledAppoinmentSuccess({super.appoinments, super.hasReachedMax});
}

class CanceledAppoinmentsFailure extends CanceledAppointmentState {
  final String failure;
  const CanceledAppoinmentsFailure(
      {super.appoinments, required this.failure, super.hasReachedMax});
}
