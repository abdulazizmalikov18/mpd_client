import 'package:mpd_client/domain/models/appointment/appointment_info_models.dart';

import 'appoinment_model.dart';

class AppointmentArgModel {
  final AppoinmentInfo appoinmentInfo;
  final Appointment appointment;

  const AppointmentArgModel(
      {required this.appoinmentInfo, required this.appointment});
}
