import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/authentication/domain/repositories/i_auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IAuthRepository authRepository;

  ForgotPasswordBloc({required this.authRepository})
    : super(const ForgotPasswordState()) {
    on<RequestPasswordResetEvent>(_onRequestPasswordReset);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResendVerificationCodeEvent>(_onResendVerificationCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onRequestPasswordReset(
    RequestPasswordResetEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ForgotPasswordStatus.requestInProgress,
        phone: event.phone,
        error: null,
      ),
    );

    final result = await authRepository.requestPasswordReset(event.phone);

    if (result.isLeft) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: result.left.message,
        ),
      );
    } else {
      emit(state.copyWith(status: ForgotPasswordStatus.requestSuccess));
    }
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ForgotPasswordStatus.verifyInProgress,
        phone: event.phone,
        code: event.code,
        error: null,
      ),
    );

    final result = await authRepository.verifyPasswordResetCode(
      event.phone,
      event.code,
    );

    if (result.isLeft) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: result.left.message,
        ),
      );
    } else {
      emit(state.copyWith(status: ForgotPasswordStatus.verifySuccess));
    }
  }

  Future<void> _onResendVerificationCode(
    ResendVerificationCodeEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ForgotPasswordStatus.resendInProgress,
        error: null,
        isResendSuccess: false,
      ),
    );

    final result = await authRepository.requestPasswordReset(event.phone);

    if (result.isLeft) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: result.left.message,
          isResendSuccess: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.resendSuccess,
          isResendSuccess: true,
        ),
      );
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    debugPrint('ResetPasswordEvent');
    if (event.newPassword != event.confirmPassword) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Passwords do not match',
        ),
      );
      return;
    }

    debugPrint('ResetPasswordEvent');
    emit(
      state.copyWith(status: ForgotPasswordStatus.resetInProgress, error: null),
    );

    final result = await authRepository.completePasswordReset(
      phone: event.phone,
      pvc: event.code,
      password1: event.newPassword,
      password2: event.confirmPassword,
    );
    debugPrint('ResetPasswordEvent');

    if (result.isLeft) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: result.left.message,
        ),
      );
    } else {
      debugPrint('ResetPasswordEvent');
      emit(state.copyWith(status: ForgotPasswordStatus.resetSuccess));
    }
  }
}
