import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:rxdart/rxdart.dart';

part 'check_username_event.dart';
part 'check_username_state.dart';

class CheckUsernameBloc extends Bloc<CheckUsernameEvent, CheckUsernameState> {
  CheckUsernameBloc(this._authRepository) : super(CheckUsernameInitial()) {
    on<CheckUsername>(
      _onCheckUsername,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }

  final AuthRepository _authRepository;

  Future<void> _onCheckUsername(
      CheckUsername event, Emitter<CheckUsernameState> emit) async {
    if (event.username.isEmpty || event.username.length < 6) {
      if (state is! CheckUsernameInitial) {
        emit(CheckUsernameInitial());
      }
      return;
    }
    emit(CheckUsernameLoading());
    final result = await _authRepository.checkUsername(event.username);

    if (result.isRight) {
      emit(CheckUsernameSuccess(result.right));
    } else {
      emit(CheckUsernameFailure(result.left.message));
    }
  }
}
