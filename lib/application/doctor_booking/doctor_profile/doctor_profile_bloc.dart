import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/models/doctor_booking/doctor_profile_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';

part 'doctor_profile_event.dart';
part 'doctor_profile_state.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  DoctorProfileBloc(this._profileRepository)
      : super(DoctorProfileInitial(null, username: '')) {
    on<GetDoctorPprofileData>(_onGetDoctorData);
    on<UpdateDoctorSubscription>(_onUpdateDoctorSubscription);
  }

  final DoctorProfileRepository _profileRepository;

  void _onUpdateDoctorSubscription(
      UpdateDoctorSubscription event, Emitter<DoctorProfileState> emit) {
    // state.doctor!.isWorking = event.doctorSubscribed;
  }

  Future<void> _onGetDoctorData(
      GetDoctorPprofileData event, Emitter<DoctorProfileState> emit) async {
    Log.wtf(state.username);
    Log.wtf(event.username);
    if (event.username == state.username) return;
    emit(DoctorProfileLoading(state.doctor, username: event.username));
    Log.wtf("Get Data");
    final result = await _profileRepository.getDoctorInfobyId(event.username);
    Log.e(result.isRight.toString());
    if (result.isRight) {
      emit(DoctorProfileSuccess(result.right, username: state.username));
      return;
    }
    emit(DoctorProfileFailure(
      result.left.errorMessage,
      state.doctor,
      username: state.username,
    ));
  }
}
