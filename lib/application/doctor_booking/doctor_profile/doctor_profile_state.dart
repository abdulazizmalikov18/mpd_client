part of 'doctor_profile_bloc.dart';

abstract class DoctorProfileState {
  DoctorProfileModel? doctor;
  final String username;
  DoctorProfileState(this.doctor, {required this.username});
}

class DoctorProfileInitial extends DoctorProfileState {
  DoctorProfileInitial(super.doctor, {required super.username});
}

class DoctorProfileLoading extends DoctorProfileState {
  DoctorProfileLoading(super.doctor, {required super.username});
}

class DoctorProfileSuccess extends DoctorProfileState {
  DoctorProfileSuccess(super.doctor, {required super.username});
}

class DoctorProfileFailure extends DoctorProfileState {
  final String failure;
  DoctorProfileFailure(this.failure, super.doctor, {required super.username});
}
