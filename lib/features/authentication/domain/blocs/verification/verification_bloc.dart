import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc(this._repository) : super(const VerificationState()) {
    on<CheckCodeEvent>(_onCheckCode);
  }

  final AuthRepository _repository;

  Future<void> _onCheckCode(
    CheckCodeEvent event,
    Emitter<VerificationState> emit,
  ) async {
    emit(state.copyWith(showLoading: true, error: ''));
    final phone =
        '+998${event.phone.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}';
    // print('Phone ________ $phone ::::: ${event.code}');

    final result = await _repository.verification(phone, event.code);
    if (result.isRight) {
      emit(
        state.copyWith(
          showLoading: false,
          isNewUser: result.right.access != null ? false : true,
          error: 'No',
        ),
      );
    } else {
      emit(state.copyWith(error: result.left.message, showLoading: false));
    }
  }
}
