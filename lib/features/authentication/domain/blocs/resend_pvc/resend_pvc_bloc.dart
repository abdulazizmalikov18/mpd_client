import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/core/utils/ticker.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'resend_pvc_event.dart';
part 'resend_pvc_state.dart';

class ResendPvcBloc extends Bloc<ResendPvcEvent, ResendPvcState> {
  final AuthRepository _repository;
  final Ticker _ticker;
  ResendPvcBloc(this._repository, this._ticker)
    : super(const ResendPvcState(buttonState: ResendButton.initial)) {
    on<ResendPvc>(_onResendPvc);
    on<StartTicker>(_startTicker);
  }

  Future<void> _startTicker(StartTicker event, Emitter<ResendPvcState> emit) {
    return emit.forEach(
      _ticker.tick(ticks: event.duration),
      onData: (duration) {
        final String minutesStr = ((duration / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final String secondsStr = (duration % 60).floor().toString().padLeft(
          2,
          '0',
        );
        return state.copyWith(duration: '$minutesStr:$secondsStr');
      },
    );
  }

  void _onResendPvc(ResendPvc event, Emitter<ResendPvcState> emit) async {
    emit(state.copyWith(buttonState: ResendButton.submitting));

    final phone =
        '+998${event.phone.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}';

    final result = await _repository.register(phone);
    if (result.isRight) {
      emit(state.copyWith(buttonState: ResendButton.timing, failure: 'No'));
      add(const StartTicker(50));
    } else {
      emit(
        state.copyWith(
          buttonState: ResendButton.timing,
          failure: result.left.message,
        ),
      );
    }
  }
}
