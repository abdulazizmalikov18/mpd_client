part of 'doctor_profile_bloc.dart';

abstract class DoctorProfileEvent extends Equatable {
  const DoctorProfileEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorPprofileData extends DoctorProfileEvent {
  final String username;
  const GetDoctorPprofileData(this.username);
}

class UpdateDoctorSubscription extends DoctorProfileEvent {
  final bool doctorSubscribed;
  const UpdateDoctorSubscription(this.doctorSubscribed);
}
