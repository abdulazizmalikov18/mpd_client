import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/auth_app_bar_component.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/comp/count_down_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class FillSmsCodePage extends StatefulWidget {
  final Function()? onClose;
  final String? password;

  const FillSmsCodePage(
      {super.key,
      required this.phoneNumber,
      required this.autofill,
      this.onClose,
      this.password});

  final String phoneNumber;
  final String autofill;

  @override
  State<FillSmsCodePage> createState() => _FillSmsCodePageState();
}

class _FillSmsCodePageState extends State<FillSmsCodePage> with CodeAutoFill {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _smsController;
  late SmsAutoFill smsAutoFill;

  late String codeValue;
  int refresh = 0;

  void verify(BuildContext context) {
    if (widget.password != null) {
      context.read<AuthBloc>().add(AuthEvent.forgotPassword(
          request: ForgotPasswordReqModel((p0) => p0
            ..phone = widget.phoneNumber
            ..phone = widget.phoneNumber
            ..code = codeValue
            ..password = widget.password)));
    } else {
      context.read<AuthBloc>().add(AuthEvent.verificationVerify(
          request: VerificationVerifyReq((p0) => p0
            ..phone = widget.phoneNumber
            ..code = codeValue)));
    }
  }

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

  @override
  void codeUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Unfocuser(
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state.successVerifyCode) {
              if (widget.password != null) {
                if (widget.onClose != null) {
                  widget.onClose!();
                } else {
                  Navigator.of(context, rootNavigator: true)
                      .pushAndRemoveUntil(AppRoutes.main(), (_) => false);
                }
              } else {
                Navigator.push(
                    context,
                    AppRoutes.getFillPersonalInfo(
                        phoneNumber: widget.phoneNumber,
                        onClose: widget.onClose));
              }
            }
          }, builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.backgroundColor,
              appBar: AuthAppBarComponent(
                isCanPop: true,
                logoPath: icons.logoIc,
                onButtonPressed: () {},
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Text(
                          "enter_code".tr(),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle2.copyWith(
                            fontSize: 19.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "an_SMS_message_with_a_code_was_sent_to".tr(args: [
                            (formatPhoneNumberAddSpaces(widget.phoneNumber))
                          ]),
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(height: 10.h),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 22.h),
                              textStyle:
                                  fonts.subtitle1.copyWith(fontSize: 15.sp),
                              foregroundColor: colors.customRed,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'edit'.tr(),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
                                    verify(context);
                                  }
                                });
                              }),
                        ),
                        SizedBox(height: 16.h),
                        CountDownComp(
                          refresh: refresh,
                          seconds: 59,
                          onTap: () {
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
              ),
              bottomNavigationBar: Column(
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
                        textStyle: fonts.subtitle2.copyWith(
                          fontSize: 13.sp,
                          decoration: TextDecoration.underline,
                        ),
                        foregroundColor: const Color(0xFF007CFF),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    onPressed: () {},
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
            );
          }),
        );
      },
    );
  }
}
