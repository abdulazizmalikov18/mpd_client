import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ChangeWithNumberPage extends StatefulWidget {
  const ChangeWithNumberPage({super.key});

  @override
  State<ChangeWithNumberPage> createState() => _ChangeWithNumberPageState();
}

class _ChangeWithNumberPageState extends State<ChangeWithNumberPage> {
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
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.successSendCode) {
            SmsAutoFill().getAppSignature.then((value) {
              Navigator.push(
                  context,
                  AppRoutes.getSafetyCodeEnterForPhone(
                    autofill: value,
                    phoneNumber: formatPhoneNumber(_phoneNumberController.text),
                  ));
            });
          }
        },
        child: Unfocuser(
          child: Scaffold(
              backgroundColor: colors.white,
              appBar: PreferredSize(
                preferredSize: Size(1.sw, 60.h),
                child: AppBarComponent(
                  title: "",
                  color: colors.white,
                ),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        36.verticalSpace,
                        Image.asset(
                          icons.changePhoneRed,
                          height: 140.w,
                          width: 140.w,
                        ),
                        36.verticalSpace,
                        Text(
                          "new_number".tr(),
                          style: fonts.subtitle2.copyWith(fontSize: 20.sp),
                        ),
                        16.verticalSpace,
                        Text(
                          "an_sms_with_a_confirmation_code_will_be_sent_to"
                              .tr(),
                          style: fonts.headline1.copyWith(
                            color: colors.text.withOpacity(0.5),
                          ),
                        ),
                        32.verticalSpace,
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
                        32.verticalSpace,
                        CustomButton(
                          // isDisabled: _phoneNumberController.text.length < 17,
                          title: "get_code".tr(),
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
                            }
                          },
                          backgroundColor: colors.customRed,
                          verticalPadding: 13.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      );
    });
  }
}
