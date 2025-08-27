import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/domain/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/features/user/presentation/widgets/custom_text_field.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phone;
  final String code;

  const ResetPasswordPage({super.key, required this.phone, required this.code});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordEye = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.register_create_password)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: context.l10n.register_new_password,
                      style: Styles.boldTopHint.copyWith(
                        color: context.color.black,
                      ),
                    ),
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: context.color.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: Styles.gilroyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(8.h),
              CustomTextField(
                controller: _newPasswordController,
                obscureText: _passwordEye,
                hintText: context.l10n.register_new_password,
                suffixIcon: _passwordEye
                    ? Icon(CupertinoIcons.eye_slash_fill)
                    : Icon(CupertinoIcons.eye_fill),
                onsuffixIconPressed: () {
                  setState(() {
                    _passwordEye = !_passwordEye;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.register_error_code_password_cant_empty;
                  }
                  if (value.length < 8) {
                    return context.l10n.register_error_code_password_mistake;
                  }
                  return null;
                },
              ),
              ScreenUtil().setVerticalSpacing(16.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: context.l10n.register_new_password_confirm,
                      style: Styles.boldTopHint.copyWith(
                        color: context.color.black,
                      ),
                    ),
                    TextSpan(
                      text: " *",
                      style: TextStyle(
                        color: context.color.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: Styles.gilroyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              ScreenUtil().setVerticalSpacing(8.h),
              CustomTextField(
                controller: _confirmPasswordController,
                obscureText: _passwordEye,
                suffixIcon: _passwordEye
                    ? Icon(CupertinoIcons.eye_slash_fill)
                    : Icon(CupertinoIcons.eye_fill),
                onsuffixIconPressed: () {
                  setState(() {
                    _passwordEye = !_passwordEye;
                  });
                },
                hintText: context.l10n.register_new_password_confirm,
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return context.l10n.register_error_code_password_missmatch;
                  }
                  return null;
                },
              ),
              const Spacer(),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == ForgotPasswordStatus.failure &&
                      state.error != null) {
                    debugPrint('ResetPasswordEvent failure');
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error!)));
                  } else if (state.status ==
                      ForgotPasswordStatus.resetSuccess) {
                    debugPrint('ResetPasswordEvent success');
                    Navigator.of(context)
                      ..pop(context)
                      ..pop()
                      ..pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10n.reset_password_success),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return WButton(
                    height: 48.h,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        debugPrint('Sending ResetPasswordEvent');
                        context.read<ForgotPasswordBloc>().add(
                          ResetPasswordEvent(
                            phone: widget.phone.replaceAll(RegExp(r'\D'), ''),
                            code: widget.code,
                            newPassword: _newPasswordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          ),
                        );
                      }
                    },
                    isLoading:
                        state.status == ForgotPasswordStatus.resetInProgress,
                    text: context.l10n.register_new_password_confirm,
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
