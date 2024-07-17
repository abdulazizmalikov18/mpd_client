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
import 'package:sms_autofill/sms_autofill.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? phoneNumber;

  const ResetPasswordPage({super.key, this.phoneNumber});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _phoneNumberController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _passwordController;
  late AutovalidateMode autoValidateMode;

  @override
  void initState() {
    autoValidateMode = AutovalidateMode.disabled;
    _phoneNumberController = TextEditingController(
        text: widget.phoneNumber != null
            ? formatPhoneNumberAddSpaces(widget.phoneNumber!)
            : "+998 ");
    _confirmPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Unfocuser(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.successSendCode) {
                Navigator.push(
                    context,
                    AppRoutes.getFillSmsCode(
                        autofill: "",
                        phoneNumber:
                            formatPhoneNumber(_phoneNumberController.text),
                        password: _confirmPasswordController.text));
              }
            },
            listenWhen: (previous, current) =>
                previous.successSendCode != current.successSendCode &&
                current.successSendCode,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.backgroundColor,
              appBar: AuthAppBarComponent(
                logoPath: icons.logoIc,
                isCanPop: false,
                onButtonPressed: () {},
              ),
              body: Form(
                key: _formKey,
                autovalidateMode: autoValidateMode,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 50.h),
                      Text(
                        "reset_password".tr(),
                        textAlign: TextAlign.center,
                        style: fonts.subtitle2.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'enter_your_phone_number_we'.tr(),
                        textAlign: TextAlign.center,
                        style: fonts.subtitle1.copyWith(
                            fontSize: 16.sp,
                            color: colors.customBlack.withOpacity(0.5)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          "number_entered_incorrectly".tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1.copyWith(
                            color: colors.customRed,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      CustomTextFieldWithIcon(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: _phoneNumberController,
                        inputFormatters: <TextInputFormatter>[
                          InternationalPhoneFormatter()
                        ],
                        icons: icons.phoneIc,
                        colors: colors,
                        validator: (String? text) {
                          if (text != null && text.length < 17) {
                            return "number_entered_incorrectly".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                      16.verticalSpace,
                      CustomTextFieldPasswordwithIcon(
                        controller: _passwordController,
                        hintText: 'new_password'.tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
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
                      SizedBox(height: 32.h),
                      CustomButton(
                        isDisabled: _phoneNumberController.text.length < 17,
                        title: "send".tr(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await SmsAutoFill().getAppSignature.then((value) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.verificationSend(
                                      request: VerificationSendReq(
                                    (p0) => p0
                                      ..phone = formatPhoneNumber(
                                          _phoneNumberController.text)
                                      ..autofill = value,
                                  )));
                            });
                          } else {
                            setState(() {
                              autoValidateMode =
                                  AutovalidateMode.onUserInteraction;
                            });
                          }
                        },
                        backgroundColor: colors.customRed,
                        verticalPadding: 13.h,
                      ),
                    ],
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
