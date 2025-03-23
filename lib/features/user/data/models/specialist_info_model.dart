class SpecialistInfoModel {
  final int id;
  final String? avatar;
  final String? fullname;
  final String? phone;
  final String? job;
  final String? appointmentName;
  final String? workingTime;
  final String? username;

  SpecialistInfoModel({
    required this.id,
    this.avatar,
    this.fullname,
    this.job,
    required this.phone,
    this.appointmentName,
    this.workingTime,
    this.username,
  });
}
