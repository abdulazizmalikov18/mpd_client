import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/utils/unfocuser.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/comp/count_down_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SafetyCodeEnterForPhonePage extends StatefulWidget {
  const SafetyCodeEnterForPhonePage({
    super.key,
    required this.phoneNumber,
    required this.autofill,
  });

  final String phoneNumber;
  final String autofill;

  @override
  State<SafetyCodeEnterForPhonePage> createState() =>
      _SafetyCodeEnterForPhonePageState();
}

class _SafetyCodeEnterForPhonePageState
    extends State<SafetyCodeEnterForPhonePage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _smsController;
  late SmsAutoFill smsAutoFill;

  late String codeValue;
  int refresh = 0;

  @override
  void initState() {
    _smsController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    smsAutoFill = SmsAutoFill();
    codeValue = "";
    //
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    _smsController.dispose();
    SmsAutoFill().unregisterListener();

    super.dispose();
  }

  void listenOtp() async {
    await smsAutoFill.listenForCode().then((value) {
      smsAutoFill.code.listen((event) {
        _smsController.text = event;
      });
    });
  }

  void codeUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Unfocuser(
          child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  (previous.successUpdatePhone != current.successUpdatePhone &&
                      current.successUpdatePhone) ||
                  (previous.errorSendCode != current.errorSendCode &&
                      current.errorSendCode),
              listener: (context, state) {
                if (state.successUpdatePhone) {
                  context
                      .read<ProfileBloc>()
                      .add(const ProfileEvent.getProfile());
                  Navigator.popUntil(context, (Route route) {
                    return route.settings.name ==
                        AppRoutes.getEditProfile(context).settings.name;
                  });
                }

                if (state.errorSendCode) {
                  _smsController.clear();
                }
              },
              builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: colors.backgroundColor,
                  appBar: AppBarComponent(
                    title: "enter_code".tr(),
                  ),
                  body: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h),
                          Text(
                            "an_SMS_message_with_a_code_was_sent_to".tr(args: [
                              (formatPhoneNumberAddSpaces(widget.phoneNumber))
                            ]),
                            textAlign: TextAlign.center,
                            style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(height: 90.h),
                          Padding(
                            padding: EdgeInsets.all(32.w),
                            child: PinFieldAutoFill(
                                autoFocus: true,
                                keyboardType: TextInputType.number,
                                controller: _smsController,
                                currentCode: codeValue,
                                cursor: Cursor(
                                  width: 2.w,
                                  height: 40.h,
                                  color: colors.primary,
                                  radius: Radius.circular(1.r),
                                  enabled: true,
                                ),
                                codeLength: 6,
                                decoration: UnderlineDecoration(
                                  textStyle: fonts.headline2.copyWith(
                                      fontSize: 32.sp, color: colors.customRed),
                                  colorBuilder:
                                      FixedColorBuilder(colors.customGreyC3),
                                ),
                                onCodeChanged: (code) {
                                  setState(() {
                                    codeValue = code.toString();
                                    if (codeValue.length == 6) {
                                      // event
                                      context.read<AuthBloc>().add(
                                          AuthEvent.updatePhone(
                                              request: VerificationVerifyReq(
                                                  (p0) => p0
                                                    ..phone = widget.phoneNumber
                                                    ..code = codeValue)));
                                    }
                                  });
                                }),
                          ),
                          SizedBox(height: 16.h),
                          CountDownComp(
                            refresh: refresh,
                            seconds: 59,
                            onTap: () {
                              _smsController.clear();
                              refresh++;
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.verificationSend(
                                      request: VerificationSendReq((p0) => p0
                                        ..phone = widget.phoneNumber
                                        ..autofill = widget.autofill)));
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
