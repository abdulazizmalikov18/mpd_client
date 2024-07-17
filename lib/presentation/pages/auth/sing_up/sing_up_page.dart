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
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SingUpPhoneNumberPage extends StatefulWidget {
  final Function()? onClose;
  const SingUpPhoneNumberPage({super.key, this.onClose});

  @override
  State<SingUpPhoneNumberPage> createState() => _SingUpPhoneNumberPageState();
}

class _SingUpPhoneNumberPageState extends State<SingUpPhoneNumberPage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _phoneNumberController = TextEditingController(text: "+998");
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Unfocuser(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: colors.backgroundColor,
            appBar: AuthAppBarComponent(
              logoPath: icons.logoIc,
            ),
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.successSendCode) {
                  SmsAutoFill().getAppSignature.then((value) {
                    Navigator.push(
                        context,
                        AppRoutes.getFillSmsCode(
                            onClose: widget.onClose,
                            autofill: value,
                            phoneNumber:
                                formatPhoneNumber(_phoneNumberController.text),
                            password: null));
                  });
                }

                if (state.proceedToLogin) {
                  Navigator.push(
                      context,
                      AppRoutes.login(
                        onClose: widget.onClose,
                        phoneNumber:
                            formatPhoneNumber(_phoneNumberController.text),
                      ));
                }
              },
              listenWhen: (previous, current) =>
                  (previous.successSendCode != current.successSendCode &&
                      current.successSendCode) ||
                  (previous.proceedToLogin != current.proceedToLogin &&
                      current.proceedToLogin),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50.h),
                      Text(
                        "enter_your_phone_number".tr(),
                        textAlign: TextAlign.center,
                        style: fonts.subtitle2.copyWith(
                          fontSize: 19.sp,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomTextFieldWithIcon(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          if (value.length >= 17) {
                            setState(() {});
                          }
                        },
                        controller: _phoneNumberController,
                        inputFormatters: <TextInputFormatter>[
                          InternationalPhoneFormatter()
                        ],
                        icons: icons.phoneIc,
                        colors: colors,
                        hintText: '+998',
                        validator: (String? text) {
                          if (text != null && text.length < 17) {
                            return "number_entered_incorrectly".tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        isDisabled: _phoneNumberController.text.length < 17,
                        title: "next".tr(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await SmsAutoFill().getAppSignature.then((value) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.checkUserFromBackend(
                                      request: VerificationSendReq(
                                    (p0) => p0
                                      ..phone = formatPhoneNumber(
                                          _phoneNumberController.text)
                                      ..autofill = value,
                                  )));
                            });
                          }
                        },
                        backgroundColor: colors.customRed,
                        verticalPadding: 13.h,
                      ),
                      const Spacer(),
                      Text(
                        "by_continuing_log_in_you_agree_with".tr(),
                        textAlign: TextAlign.center,
                        style: fonts.subtitle1.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: const Color(0xFF007CFF),
                            textStyle: fonts.subtitle2.copyWith(
                              color: const Color(0xFF007CFF),
                              fontSize: 13.sp,
                              decoration: TextDecoration.underline,
                            ),
                            minimumSize: Size(50, 22.h),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FillPersonalInfoPage(
                          //               context: context,
                          //             )));
                        },
                        child: Text(
                          'privacy_policy'.tr(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: kBottomNavigationBarHeight,
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
