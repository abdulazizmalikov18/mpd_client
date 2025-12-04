// In password_part.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/domain/blocs/change_password/change_password_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/have_account_text_widget.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class PasswordPart extends StatefulWidget {
  final String phone;
  final ValueNotifier valueNotifier;

  const PasswordPart({
    super.key,
    required this.phone,
    required this.valueNotifier,
  });

  @override
  State<PasswordPart> createState() => _PasswordPartState();
}

class _PasswordPartState extends State<PasswordPart> {
  @override
  void initState() {
    super.initState();
    // Set default values for hidden fields
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final createUserBloc = context.read<CreateUserBloc>();
      // Generate a random username based on phone number
      final username =
          'user_${widget.phone.substring(widget.phone.length - 4)}';
      createUserBloc.userNameController.text = username;
      createUserBloc.firsNameController.text = 'User';
      createUserBloc.lastNameController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ScreenUtil().setVerticalSpacing(24.h),
        Text(
          context.l10n.register_create_password,
          textAlign: TextAlign.center,
          style: Styles.boldTitle,
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        Form(
          key: context.read<ChangePasswordBloc>().formKey,
          child: Column(
            children: [
              // Only show password fields
              BlocSelector<ChangePasswordBloc, ChangePasswordState, bool>(
                selector: (state) => state.newPasswordEye,
                builder: (context, newPasswordEye) {
                  return LabelInputWidget(
                    require: '*',
                    obsecure: newPasswordEye,
                    textInputAction: TextInputAction.next,
                    topHint: context.l10n.register_new_password,
                    inputHint: context.l10n.register_new_password,
                    validator: (value) =>
                        Validators.createPassword(value, context),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ChangePasswordBloc>().add(
                          MakeVisibleNewPassword(),
                        );
                      },
                      icon: Icon(
                        newPasswordEye
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    controller: context
                        .read<ChangePasswordBloc>()
                        .password1Controller,
                  );
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              BlocSelector<ChangePasswordBloc, ChangePasswordState, bool>(
                selector: (state) => state.confirmPasswordEye,
                builder: (context, confirmPasswordEye) {
                  return LabelInputWidget(
                    require: '*',
                    obsecure: confirmPasswordEye,
                    textInputAction: TextInputAction.done,
                    topHint: context.l10n.register_new_password_confirm,
                    inputHint: context.l10n.register_new_password_confirm,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<ChangePasswordBloc>().add(
                          MakeVisibleConfirmPassword(),
                        );
                      },
                      icon: Icon(
                        confirmPasswordEye
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return context
                            .l10n
                            .register_error_code_password_cant_empty;
                      }
                      if (value !=
                          context
                              .read<ChangePasswordBloc>()
                              .password1Controller
                              .text) {
                        return context
                            .l10n
                            .register_error_code_password_missmatch;
                      }
                      return null;
                    },
                    controller: context
                        .read<ChangePasswordBloc>()
                        .password2Controller,
                  );
                },
              ),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) async {
            if (state.showLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialogWidget(),
              );
            }

            if (!state.showLoading && state.error == 'No' && state.isCorrect) {
              Navigator.pop(context);
              // Submit user creation with default values
              _submitUserCreation(context);
            } else if (!state.showLoading && state.error == 'No') {
              // Navigator.pop(context);
              await Future.delayed(const Duration(milliseconds: 250)).then((
                value,
              ) {
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainPage,
                    (route) => false,
                  );
                }
              });
            } else if (!state.showLoading &&
                state.error != 'No' &&
                state.error != '') {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  UiTools.failSnackbar(
                    title: Utils.errorFormat(state.error),
                    context: context,
                  ),
                );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: LongButton(
              buttonName: context.l10n.register_password_continue,
              onPress: () {
                context.read<ChangePasswordBloc>().add(
                  OnlyCheckPasswordEvent(),
                );
              },
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        HaveAccountTextWidget(
          info: context.l10n.register_have_account,
          buttonText: context.l10n.login_enter,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.auth,
              (route) => false,
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(40.h),
      ],
    );
  }

  void _submitUserCreation(BuildContext context) {
    final password = context
        .read<ChangePasswordBloc>()
        .password1Controller
        .text;
    final createUserBloc = context.read<CreateUserBloc>();

    // Submit with default values
    createUserBloc.add(
      ForCreateUserEvent(phone: widget.phone, password: password),
    );
  }
}
