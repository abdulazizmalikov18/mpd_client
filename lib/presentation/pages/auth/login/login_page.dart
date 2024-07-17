import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field_password.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/component/custom_underline_button.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class LoginPage extends StatefulWidget {
  final String? phoneNumber;
  final Function()? onClose;

  const LoginPage({super.key, this.phoneNumber, this.onClose});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;

  late bool isCorrectNumber;
  late bool isSavePassword;

  @override
  void initState() {
    _phoneNumberController = TextEditingController(
        text: widget.phoneNumber != null
            ? InternationalPhoneFormatter()
                .internationalPhoneFormat(widget.phoneNumber!)
            : "+998");
    _passwordController = TextEditingController();
    isCorrectNumber = true;
    isSavePassword = false;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
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
              }
            },
            listenWhen: (previous, current) =>
                previous.proceedToHome != current.proceedToHome &&
                current.proceedToHome,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.backgroundColor,
              appBar: AppBar(
                backgroundColor: colors.colorF5F5F5,
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                icons.logoIc,
                                height: 58.h,
                                fit: BoxFit.contain,
                              ).animate().fade().slideX(duration: 0.5.seconds),
                            ),
                            SizedBox(height: 50.h),
                            isCorrectNumber
                                ? SizedBox(height: 30.h)
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Text(
                                      "number_entered_incorrectly".tr(),
                                      textAlign: TextAlign.center,
                                      style: fonts.subtitle1.copyWith(
                                        color: colors.customRed,
                                        fontSize: 15.sp,
                                      ),
                                    )
                                        .animate()
                                        .fade()
                                        .slideX(duration: 0.5.seconds),
                                  ),
                            CustomTextFieldWithIcon(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please_enter_your_phone_number'.tr();
                                } else if (value.length < 17) {
                                  return 'please_enter_valid_phone_number'.tr();
                                } else {
                                  return null;
                                }
                              },
                              controller: _phoneNumberController,
                              inputFormatters: <TextInputFormatter>[
                                InternationalPhoneFormatter()
                              ],
                              icons: icons.phoneIc,
                              colors: colors,
                              hintText: '+998',
                            ).animate().fade().slideX(
                                duration: 0.5.seconds,
                                begin: 1 - SlideEffect.neutralSlide),
                            15.verticalSpace,
                            CustomTextFieldPasswordwithIcon(
                              controller: _passwordController,
                              hintText: 'password'.tr(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please_enter_new_password'.tr();
                                }
                                return null;
                              },
                            ).animate().fade().slideX(duration: 0.5.seconds),
                            35.verticalSpace,
                            CustomUnderlineTextButton(
                              colors: colors,
                              fonts: fonts,
                              fontSize: 16.sp,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    AppRoutes.getResetPassword(
                                        phoneNumber: formatPhoneNumber(
                                            _phoneNumberController.text)));
                              },
                              text: 'forgot_your_password'.tr(),
                            ),
                            25.verticalSpace,
                            CustomButton(
                              title: "login".tr(),
                              onPressed: () {
                                if (_phoneNumberController.text.length < 17) {
                                  setState(() {
                                    isCorrectNumber = false;
                                  });
                                } else {
                                  setState(() {
                                    isCorrectNumber = true;
                                  });
                                }
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthEvent.signIn(
                                          request: SignInReq(
                                        (b) => b
                                          ..phone = formatPhoneNumber(
                                              _phoneNumberController.text)
                                          ..password = _passwordController.text,
                                      )));
                                } else {
                                  setState(() {});
                                }
                              },
                              backgroundColor: colors.customRed,
                              verticalPadding: 13.h,
                            ),
                          ],
                        ),
                        32.verticalSpace,
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 8),
                          child: CustomUnderlineTextButton(
                            colors: colors,
                            fonts: fonts,
                            fontSize: 18.sp,
                            onPressed: () {
                              Navigator.push(context,
                                  AppRoutes.singUp(onClose: widget.onClose));
                            },
                            text: 'registration'.tr(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
