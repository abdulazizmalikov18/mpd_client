import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field_password.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChangePasswordProfilePage extends StatefulWidget {
  const ChangePasswordProfilePage({super.key});

  @override
  State<ChangePasswordProfilePage> createState() =>
      _ChangePasswordProfilePageState();
}

class _ChangePasswordProfilePageState extends State<ChangePasswordProfilePage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _oldPasswordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _passwordController;

  late AutovalidateMode autovalidateMode;

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return OnUnFocusTap(
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.proceedToHome != current.proceedToHome &&
              current.proceedToHome,
          listener: (context, state) {
            if (state.proceedToHome) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: colors.colorF5F5F5,
            appBar: AppBarComponent(
              title: "change_password".tr(),
              // color: colors.backgroundScaffold,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    children: [
                      Text(
                        'password_must_be_characters'.tr(),
                        textAlign: TextAlign.center,
                        style: fonts.headline1
                            .copyWith(color: colors.text.withOpacity(0.5)),
                      ),
                      20.verticalSpace,
                      Column(
                        children: [
                          Text(
                            'password_entered_incorrectly'.tr(),
                            textAlign: TextAlign.center,
                            style:
                                fonts.headline1.copyWith(color: colors.primary),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                      CustomTextFieldPasswordwithIcon(
                        controller: _oldPasswordController,
                        isPassword: true,
                        hintText: "old_password".tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please_repeat_the_password'.tr();
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,
                      CustomTextFieldPasswordwithIcon(
                        controller: _passwordController,
                        hintText: 'new_password'.tr(),
                        validator: (value) {
                          if (value!.isEmpty ||
                              value == _oldPasswordController.text) {
                            return 'please_enter_new_password'.tr();
                          }
                          if (value.length < 4) {
                            return "password_validation".tr();
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,
                      CustomTextFieldPasswordwithIcon(
                        controller: _confirmPasswordController,
                        hintText: 'repeat_password'.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please_repeat_the_password'.tr();
                          }
                          if (value != _passwordController.text) {
                            return 'passwords_do_not_match'.tr();
                          }
                          return null;
                        },
                      ),
                      16.verticalSpace,
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        splashColor: colors.transparent,
                        onTap: () {
                          Navigator.push(context, AppRoutes.getResetPassword());
                        },
                        title: Text(
                          'forgot_your_password'.tr(),
                          style: fonts.headline1.copyWith(
                            decoration: TextDecoration.underline,
                            color: colors.text.withOpacity(0.7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEvent.updatePassword(
                                        request: ResetPasswordReq(
                                      (p0) => p0
                                        ..newPwd = _passwordController.text
                                        ..oldPwd = _oldPasswordController.text,
                                    )));
                              } else {}
                            } else {
                              setState(() {
                                autovalidateMode =
                                    AutovalidateMode.onUserInteraction;
                              });
                            }
                          },
                          backgroundColor: colors.primary,
                          title: "save".tr(),
                          verticalPadding: 13.h,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
