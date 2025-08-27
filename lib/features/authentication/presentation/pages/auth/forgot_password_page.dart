import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/domain/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:mpd_client/features/authentication/presentation/pages/auth/forgot_verify_page.dart';
import 'package:mpd_client/features/chat/presentation/widgets/message_widgets/w_button.dart';
import 'package:mpd_client/features/user/presentation/widgets/custom_text_field.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/tools/formatters.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == ForgotPasswordStatus.requestSuccess) {
          final bloc = context.read<ForgotPasswordBloc>();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: ForgotVerifyPage(
                  phone: _phoneController.text.replaceAll(RegExp(r'\D'), ''),
                ),
              ),
            ),
          );
        } else if (state.status == ForgotPasswordStatus.failure &&
            state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.forgotPassword)),
        body: Padding(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    context.l10n.restore_account,
                    textAlign: TextAlign.center,
                    style: Styles.headline6.copyWith(),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _phoneController,
                  hintText: "+998 (00) 000-00-00",
                  title: context.l10n.restore_phone,
                  keyboardType: TextInputType.phone,
                  formatter: [Formatters.phoneFormatter],
                  validator: (value) =>
                      Validators.usernameOrPhone(value, context),
                ),
                const Spacer(),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    return WButton(
                      height: 48.h,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgotPasswordBloc>().add(
                            RequestPasswordResetEvent(
                              _phoneController.text.replaceAll(
                                RegExp(r'\D'),
                                '',
                              ),
                            ),
                          );
                        }
                      },
                      isLoading:
                          state.status ==
                          ForgotPasswordStatus.requestInProgress,
                      text: context.l10n.register_password_continue,
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
