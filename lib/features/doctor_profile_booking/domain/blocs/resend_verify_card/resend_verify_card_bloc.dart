import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/core/utils/ticker.dart';
import 'package:mpd_client/features/doctor_profile_booking/data/repositories/doctor_profile_repository.dart';

part 'resend_verify_card_event.dart';
part 'resend_verify_card_state.dart';

class ResendVerifyCardBloc
    extends Bloc<ResendVerifyCardEvent, ResendVerifyCardState> {
  ResendVerifyCardBloc(this._profileRepository, this._ticker)
      : super(const ResendVerifyCardInitial('')) {
    on<ResendVerifyCard>(_onResendVerifyCard);
    on<StartTicker>(_startTicker);
  }

  final DoctorProfileRepository _profileRepository;
  final Ticker _ticker;

  Future<void> _startTicker(
      StartTicker event, Emitter<ResendVerifyCardState> emit) {
    return emit.forEach(
      _ticker.tick(ticks: event.duration),
      onData: (duration) {
        final String minutesStr =
            ((duration / 60) % 60).floor().toString().padLeft(2, '0');
        final String secondsStr =
            (duration % 60).floor().toString().padLeft(2, '0');

        return ResendVerifyCardSuccess('$minutesStr:$secondsStr');
      },
    );
  }

  Future<void> _onResendVerifyCard(
      ResendVerifyCard event, Emitter<ResendVerifyCardState> emit) async {
    emit(ResendVerifyCardLoading(state.duration));

    final result = await _profileRepository.resendverifyCode(cardId: event.id);
    if (result.isRight) {
      emit(ResendVerifyCardSuccess(state.duration));
      add(const StartTicker(60));
    } else {
      emit(ResendVerifyCardFailure(result.left.message, state.duration));
    }
  }
}
