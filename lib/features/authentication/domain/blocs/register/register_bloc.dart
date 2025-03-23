import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._repository, this._formKey, this._phoneController)
      : super(const RegisterState()) {
    on<PrivacyReatPressed>(_onPrivacyReat);
    on<RegisterButtonPressed>(_onRegisterPressed);

    on<AccountDisabled>(_accountDisabled);
  }

  final AuthRepository _repository;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _phoneController;

  GlobalKey get formKey => _formKey;
  TextEditingController get phoneController => _phoneController;

  void _onPrivacyReat(PrivacyReatPressed event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isPrivacyReat: !state.isPrivacyReat));
  }

  void _accountDisabled(AccountDisabled event, Emitter<RegisterState> emit)async {
    final result = await _repository.disabledAccount();
    if (result.isRight) {
      event.onSucces();
    } else {
      event.onError();
    }
  }

  void _onRegisterPressed(
      RegisterButtonPressed event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(error: ''));
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(showLoading: true));
      final phone =
          '+998${_phoneController.text.replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}';

      final result = await _repository.register(phone);
      if (result.isRight) {
        emit(state.copyWith(
            showLoading: false,
            error: result.right ? 'This user still exist' : 'Well'));
      } else {
        if (result.left is NetworkFailure) {
          emit(state.copyWith(error: result.left.message, showLoading: false));
        } else {
          emit(state.copyWith(
              error: 'Unknown server error', showLoading: false));
        }
      }
    }
  }
}
