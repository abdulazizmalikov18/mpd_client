import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/models/card_remote_model.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';

part 'verify_card_event.dart';
part 'verify_card_state.dart';

class VerifyCardBloc extends Bloc<VerifyCardEvent, VerifyCardState> {
  VerifyCardBloc(this._profileRepository)
      : super(const VerifyCardInitial(null)) {
    on<VerifyCard>(_onVerifyCard);
  }

  final DoctorProfileRepository _profileRepository;

  Future<void> _onVerifyCard(
      VerifyCard event, Emitter<VerifyCardState> emit) async {
    emit(VerifyCardLoading(state.card));

    final result = await _profileRepository.verifyCard(
        code: event.code, cardId: event.cardId);
    if (result.isRight) {
      emit(VerifyCardSuccess(result.right));
    } else {
      emit(VerifyCardFailure(result.left.message, state.card));
    }
  }
}
