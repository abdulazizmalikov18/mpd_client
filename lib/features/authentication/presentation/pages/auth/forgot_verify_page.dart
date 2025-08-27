import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/authentication/domain/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:mpd_client/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:pinput/pinput.dart';
import 'reset_password_page.dart';

class ForgotVerifyPage extends StatefulWidget {
  final String phone;

  const ForgotVerifyPage({super.key, required this.phone});

  @override
  _ForgotVerifyPageState createState() => _ForgotVerifyPageState();
}

class _ForgotVerifyPageState extends State<ForgotVerifyPage>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late Timer _resendTimer;
  int _resendCountdown = 120; // 2 minutes in seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _resendTimer.cancel();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 120; // Reset to 2 minutes
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _resendTimer.cancel();
      }
    });
  }

  String _formatCountdown(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.verifySuccess) {
          final authRepository = locator<IAuthRepository>();
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ForgotPasswordBloc(
                  authRepository: authRepository,
                ),
                child: ResetPasswordPage(
                  phone: widget.phone,
                  code: _codeController.text,
                ),
              ),
            ),
          );
        } else if (state.status == ForgotPasswordStatus.resendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.register_verify_code_sent_again),
            ),
          );
        } else if (state.status == ForgotPasswordStatus.resetSuccess) {
          Navigator.popUntil(context, (route) => route.isFirst);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successfully')),
          );
        } else if (state.status == ForgotPasswordStatus.failure &&
            state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.register_verify_code)),
        body: Padding(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${context.l10n.register_verify_code_description}\n ${Utils.maskPhone(widget.phone)}',
                  textAlign: TextAlign.center,
                  style: Styles.headline6.copyWith(color: context.color.grey),
                ),
                SizedBox(height: 24.h),
                Pinput(
                  length: 6,
                  controller: _codeController,
                  validator: (value) {
                    if (value == null || value.length != 6) {
                      return 'Please enter a valid code';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: _canResend
                      ? () {
                          context.read<ForgotPasswordBloc>().add(
                            ResendVerificationCodeEvent(widget.phone),
                          );
                          _startResendTimer();
                        }
                      : null,
                  child: Text(
                    _canResend
                        ? context.l10n.register_verify_code_sent_again
                        : '${context.l10n.register_verify_code_sent_again} ${_formatCountdown(_resendCountdown)}',
                    style: TextStyle(
                      color: _canResend
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
                const Spacer(),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    return WButton(
                      height: 48.h,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgotPasswordBloc>().add(
                            VerifyResetCodeEvent(
                              widget.phone.replaceAll(RegExp(r'\D'), ''),
                              _codeController.text,
                            ),
                          );
                        }
                      },
                      isLoading: state.status == ForgotPasswordStatus.verifyInProgress,
                      text: context.l10n.register_create_password,
                    );
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
