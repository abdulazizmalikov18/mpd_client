part of 'cancel_appointment_bloc.dart';

abstract class CancelAppointmentEvent extends Equatable {
  const CancelAppointmentEvent();

  @override
  List<Object> get props => [];
}

class CancelPressedEvent extends CancelAppointmentEvent {
  final String productid;
  final String cancelInfo;

  const CancelPressedEvent({required this.productid, required this.cancelInfo});
}
