import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/auth_app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field_password.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class FillPersonalInfoPage extends StatefulWidget {
  final Function()? onClose;
  const FillPersonalInfoPage(
      {super.key, required this.phoneNumber, this.onClose});

  final String phoneNumber;

  @override
  State<FillPersonalInfoPage> createState() => _FillPersonalInfoPageState();
}

class _FillPersonalInfoPageState extends State<FillPersonalInfoPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _phonenumberlController;
  late TextEditingController _namelController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late AutovalidateMode autoValidateMode;

  @override
  void initState() {
    super.initState();
    autoValidateMode = AutovalidateMode.disabled;
    _phonenumberlController = TextEditingController(
        text: formatPhoneNumberAddSpaces(widget.phoneNumber));
    _namelController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _phonenumberlController.dispose();
    _namelController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Unfocuser(
          child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.proceedToHome) {
                  if (widget.onClose != null) {
                    widget.onClose!();
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context, AppRoutes.main(), (route) => false);
                  }
                } else {
                  Navigator.pushAndRemoveUntil(
                      context, AppRoutes.login(), (route) => false);
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: colors.backgroundColor,
                appBar: AuthAppBarComponent(
                  logoPath: icons.logoIc,
                  isCanPop: true,
                  onButtonPressed: () {},
                ),
                body: Form(
                  autovalidateMode: autoValidateMode,
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          'entering_personal_information'.tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle2.copyWith(
                            fontSize: 19.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFieldWithIcon(
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {},
                          controller: _phonenumberlController,
                          inputFormatters: <TextInputFormatter>[
                            InternationalPhoneFormatter()
                          ],
                          icons: icons.phoneIc,
                          colors: colors,
                          hintText: '+998 94 123 45 67',
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFieldWithIcon(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "please_enter_a_name".tr();
                            } else {
                              return null;
                            }
                          },
                          controller: _namelController,
                          icons: icons.peronIc,
                          colors: colors,
                          hintText: 'nodir_sultonov'.tr(),
                        ),
                        15.verticalSpace,
                        CustomTextFieldPasswordwithIcon(
                          controller: _passwordController,
                          hintText: 'password'.tr(),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'please_enter_new_password'.tr();
                              }

                              if (value.length < 4) {
                                return "password_validation".tr();
                              }
                            }
                            return null;
                          },
                        ),
                        15.verticalSpace,
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
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomButton(
                          // isDisabled: _phonenumberlController.text.length < 17,
                          title: "save".tr(),
                          onPressed: () {
                            // Navigator.push(context, AppRoutes.main(index: 0));
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthEvent.registration(
                                        request: RegisterReq(
                                      (p0) => p0
                                        ..fullName = _namelController.text
                                        ..password = _passwordController.text,
                                    )));
                              }
                            } else {
                              autoValidateMode =
                                  AutovalidateMode.onUserInteraction;
                              setState(() {});
                            }
                          },
                          backgroundColor: colors.customRed,
                          verticalPadding: 13.h,
                        ),
                        SizedBox(
                          height: 48.h,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'by_continuing_log_in_you_agree_with'.tr(),
                              textAlign: TextAlign.center,
                              style: fonts.subtitle1.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 22.h),
                                  foregroundColor: const Color(0xFF007CFF),
                                  textStyle: fonts.subtitle2.copyWith(
                                    color: const Color(0xFF007CFF),
                                    fontSize: 13.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: () {},
                              child: Text(
                                'privacy_policy'.tr(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: kBottomNavigationBarHeight),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
