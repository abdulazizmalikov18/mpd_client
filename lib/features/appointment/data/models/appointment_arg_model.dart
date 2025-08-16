import '../../../../src/appointment_info/appointment_info_model.dart';
import 'appoinment_model.dart';

class AppointmentArgModel {
  final AppoinmentInfo appoinmentInfo;
  final Appointment appointment;

  const AppointmentArgModel({
    required this.appoinmentInfo,
    required this.appointment,
  });
}
