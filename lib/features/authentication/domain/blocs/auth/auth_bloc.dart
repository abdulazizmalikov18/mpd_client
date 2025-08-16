import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/core/utils/either.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/features/authentication/data/models/token_model.dart';
import 'package:mpd_client/features/authentication/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._repository,
    this._formKey,
    this._phoneController,
    this._username,
    this._phoneFocus,
  ) : super(const AuthState()) {
    on<PasswordTextFieldChanged>(_onPasswordTextFieldChanged);
    on<EyeIconPressed>(_onEyeIconPressed);
    on<LoginButtonPressed>(_onLoginPressed);
    on<BackButtonPressed>(_onBackPressed);
    on<DeleteToken>(_onDeleteToken);
    on<RefreshToken>(_onRefreshToken);
    on<ChangePhoneorUsername>(_onChangePhoneorUsername);
  }

  final AuthRepository _repository;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _phoneController;
  final TextEditingController _username;
  final FocusNode _phoneFocus;

  GlobalKey get formKey => _formKey;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get username => _username;
  FocusNode get phoneFocys => _phoneFocus;

  void _onPasswordTextFieldChanged(
    PasswordTextFieldChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onChangePhoneorUsername(
    ChangePhoneorUsername event,
    Emitter<AuthState> emit,
  ) {
    if (event.value.length > 1) return;
    if (event.value.isEmpty) {
      emit(state.copyWith(phoneOrUsername: PhoneOrUsername.initial));
    } else if (int.tryParse(event.value.characters.first) != null) {
      emit(state.copyWith(phoneOrUsername: PhoneOrUsername.phone));
    } else if (event.value.characters.first.startsWith("+")) {
      emit(state.copyWith(phoneOrUsername: PhoneOrUsername.phone));
    } else {
      emit(state.copyWith(phoneOrUsername: PhoneOrUsername.username));
    }
  }

  Future<void> _onDeleteToken(
    DeleteToken event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await StorageRepository.deleteString(StorageKeys.REFRESH);
      await StorageRepository.deleteString(StorageKeys.TOKEN);
      emit(state.copyWith(isDeletedToken: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onRefreshToken(
    RefreshToken event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final respons = await _repository.refreshToken();
      if (respons.isRight) {
        await resetLocator();
      } else {
        debugPrint("======>>>> ${respons.left}");
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onLoginPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint("login");
    if (_formKey.currentState!.validate()) {
      emit(state.copyWith(showLoginButtonLoading: true, error: ''));
      final result = await _result();
      if (result.isRight) {
        emit(state.copyWith(showLoginButtonLoading: false, error: 'No'));
      } else {
        debugPrint("failure");
        event.onError();
        if (result.left is NetworkFailure) {
          emit(
            state.copyWith(
              error: result.left.message,
              showLoginButtonLoading: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              error: 'Unknown server error',
              showLoginButtonLoading: false,
            ),
          );
        }
      }
    }
  }

  Future<Either<Failure, TokenModel>> _result() async {
    Log.w("Biz Bu yerdamiz");
    if (_username.text.isNotEmpty) {
      return await _repository.login(
        username: _username.text,
        password: state.password,
        rememberMe: true,
      );
    } else {
      final phone = _phoneController.text
          .replaceAll('-', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll(' ', '');

      return await _repository.login(
        phone: phone,
        password: state.password,
        rememberMe: true,
      );
    }
  }

  void _onEyeIconPressed(EyeIconPressed event, Emitter<AuthState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void _onBackPressed(BackButtonPressed event, Emitter<AuthState> emit) {
    emit(state.copyWith(error: ''));
  }
}
