import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(this._repository, this._formKey, this._passwordController1,
      this._passwordController2, this._oldPasswordController)
      : super(const ChangePasswordState()) {
    on<CheckPasswordAndChange>(_onCheckAndChangePassword);
    on<OnlyCheckPasswordEvent>(_onOnlyCheckPassword);
    on<MakeVisibleNewPassword>(_onMakeVisibleNewPassword);
    on<MakeVisibleConfirmPassword>(_onMakeVisibleConfirmPassword);
  }

  final AuthRepository _repository;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _passwordController1;
  final TextEditingController _passwordController2;
  final TextEditingController _oldPasswordController;

  GlobalKey get formKey => _formKey;
  TextEditingController get password1Controller => _passwordController1;
  TextEditingController get password2Controller => _passwordController2;
  TextEditingController get oldPasswordController => _oldPasswordController;

  Future<void> _onOnlyCheckPassword(
      OnlyCheckPasswordEvent event, Emitter<ChangePasswordState> emit) async {
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(error: 'No'));

      emit(state.copyWith(showLoading: true));
      final result = await _repository.checkPassword(_passwordController2.text);
      if (result.isRight) {
        emit(state.copyWith(
            showLoading: false, error: 'No', isCorrect: result.right));
      } else {
        if (result.left is NetworkFailure) {
          emit(state.copyWith(error: result.left.message, showLoading: false));
        } else {
          emit(state.copyWith(error: result.left.message, showLoading: false));
        }
      }
    }
  }

  Future<void> _onCheckAndChangePassword(
      CheckPasswordAndChange event, Emitter<ChangePasswordState> emit) async {
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(error: 'No'));

      emit(state.copyWith(showLoading: true));
      final result = await _repository.changePassword(_passwordController2.text,
          oldPassword: oldPasswordController.text);
      if (result.isRight) {
        emit(state.copyWith(showLoading: false, error: 'No'));
      } else {
        if (result.left is NetworkFailure) {
          emit(state.copyWith(error: result.left.message, showLoading: false));
        } else {
          emit(state.copyWith(error: result.left.message, showLoading: false));
        }
      }
    }
  }

  void _onMakeVisibleNewPassword(
          MakeVisibleNewPassword event, Emitter<ChangePasswordState> emit) =>
      emit(state.copyWith(newPasswordEye: !state.newPasswordEye));

  void _onMakeVisibleConfirmPassword(MakeVisibleConfirmPassword event,
          Emitter<ChangePasswordState> emit) =>
      emit(state.copyWith(confirmPasswordEye: !state.confirmPasswordEye));
}
