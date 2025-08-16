import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/doctor_profile_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';

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
    UpdateDoctorSubscription event,
    Emitter<DoctorProfileState> emit,
  ) {
    // state.doctor!.isWorking = event.doctorSubscribed;
  }

  Future<void> _onGetDoctorData(
    GetDoctorPprofileData event,
    Emitter<DoctorProfileState> emit,
  ) async {
    if (event.username == state.username) return;
    emit(DoctorProfileLoading(state.doctor, username: event.username));

    final result = await _profileRepository.getDoctorInfobyId(event.username);
    if (result.isRight) {
      emit(DoctorProfileSuccess(result.right, username: state.username));
    } else {
      emit(
        DoctorProfileFailure(
          result.left.message,
          state.doctor,
          username: state.username,
        ),
      );
    }
  }
}
