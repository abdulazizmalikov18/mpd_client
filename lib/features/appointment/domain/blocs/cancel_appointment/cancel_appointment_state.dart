part of 'cancel_appointment_bloc.dart';

abstract class CancelAppointmentState extends Equatable {
  const CancelAppointmentState();

  @override
  List<Object> get props => [];
}

class CancelAppointmentInitial extends CancelAppointmentState {}

class CancelAppointmentLoading extends CancelAppointmentState {}

class CancelAppointmentSuccess extends CancelAppointmentState {}

class CancelAppointmentFailure extends CancelAppointmentState {
  final String failure;
  const CancelAppointmentFailure(this.failure);
}
