import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneAddComp extends StatefulWidget {
  const PhoneAddComp({super.key});

  @override
  State<PhoneAddComp> createState() => _PhoneAddCompState();
}

class _PhoneAddCompState extends State<PhoneAddComp> {
  late TextEditingController _phoneNumberController;
  late TextEditingController _phoneNumberController2;
  late bool hasSecondNumber;
  late BuildContext buildContext;

  @override
  void initState() {
    _phoneNumberController = TextEditingController(text: "+998");
    _phoneNumberController2 = TextEditingController(text: "+998");
    hasSecondNumber = false;
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return BlocBuilder<AddCarBloc, AddCarState>(
          builder: (context, stateAddCar) {
        return BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                (previous.successSendCode != current.successSendCode &&
                    current.successSendCode) ||
                (previous.successVerifyCode != current.successVerifyCode &&
                    current.successVerifyCode),
            listener: (context, state) {
              if (state.successSendCode) {
                showBottomSheet(
                    context: context,
                    builder: (BuildContext ctx) => SmsVerificationDialog(
                          phoneNumber: state.phoneNumber ?? "",
                          onTap: (String? code) {
                            buildContext = ctx;
                            context
                                .read<AuthBloc>()
                                .add(AuthEvent.additionalNumberVerify(
                                    request: VerificationVerifyReq((p0) => p0
                                      ..phone = state.phoneNumber
                                      ..code = code)));
                          },
                        ));
              }
              if (state.successVerifyCode) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Navigator.pop(buildContext);
                List<AdditionalPhones> additional =
                    stateAddCar.createCarReq?.additionalPhones?.toList() ?? [];
                additional.add(
                    AdditionalPhones((p0) => p0..number = state.phoneNumber));
                CreateCarReq req = (stateAddCar.createCarReq ?? CreateCarReq())
                    .rebuild((p0) => p0
                      ..additionalPhones =
                          additional.toBuiltList().toBuilder());

                context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                    createCarReq: req, filterType: FilterType.none));
                setState(() {
                  _phoneNumberController.text = "+998";
                  _phoneNumberController2.text = "+998";
                });
              }
            },
            builder: (context, stateAuth) {
              return OnUnFocusTap(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'phone'.tr(),
                      style: fonts.subtitle2.copyWith(fontSize: 14.sp),
                    ),
                    8.verticalSpace,
                    if (stateAddCar.createCarReq?.additionalPhones != null &&
                        stateAddCar.createCarReq!.additionalPhones!.isNotEmpty)
                      Column(
                        children: stateAddCar.createCarReq?.additionalPhones
                                ?.map((p0) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        InternationalPhoneFormatter()
                                            .internationalPhoneFormat(
                                                p0.number ?? ""),
                                        style: fonts.subtitle2,
                                      ),
                                      leading: icons.checkGrey
                                          .svg(color: colors.customGreen),
                                      trailing: IconButton(
                                        icon: icons.delete
                                            .svg(color: colors.primary),
                                        onPressed: () {
                                          List<AdditionalPhones> additional =
                                              stateAddCar.createCarReq
                                                      ?.additionalPhones
                                                      ?.toList() ??
                                                  [];
                                          if (p0.id != null) {
                                            context.read<AddCarBloc>().add(
                                                AddCarEvent
                                                    .deletePhoneNumberDraft(
                                                        id: p0.id!));
                                          }
                                          additional.remove(p0);
                                          CreateCarReq req = (stateAddCar
                                                      .createCarReq ??
                                                  CreateCarReq())
                                              .rebuild((p0) => p0
                                                ..additionalPhones = additional
                                                    .toBuiltList()
                                                    .toBuilder());
                                          context.read<AddCarBloc>().add(
                                              AddCarEvent.setFilterValue(
                                                  createCarReq: req,
                                                  filterType: FilterType.none));
                                        },
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                    if (stateAddCar.createCarReq?.additionalPhones?.isEmpty ??
                        true)
                      CustomTextFieldWithIcon(
                        keyboardType: TextInputType.phone,
                        onChanged: (text) {
                          if (text.length >= 17) {
                            SmsAutoFill().getAppSignature.then((value) {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.verificationSend(
                                      request: VerificationSendReq((p0) => p0
                                        ..phone =
                                            text.trim().replaceAll(" ", "")
                                        ..autofill = value)));
                            });
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }
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
                    if ((stateAddCar.createCarReq?.additionalPhones?.length ??
                            0) <
                        2)
                      Column(
                        children: [
                          hasSecondNumber
                              ? Padding(
                                  padding: EdgeInsets.only(top: 16.h),
                                  child: CustomTextFieldWithIcon(
                                    keyboardType: TextInputType.phone,
                                    onChanged: (text) {
                                      if (text.length >= 17) {
                                        SmsAutoFill()
                                            .getAppSignature
                                            .then((value) {
                                          context.read<AuthBloc>().add(
                                              AuthEvent.verificationSend(
                                                  request: VerificationSendReq(
                                                      (p0) => p0
                                                        ..phone = text
                                                            .trim()
                                                            .replaceAll(" ", "")
                                                        ..autofill = value)));
                                        });
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      }
                                    },
                                    controller: _phoneNumberController2,
                                    inputFormatters: <TextInputFormatter>[
                                      InternationalPhoneFormatter()
                                    ],
                                    icons: icons.phoneIc,
                                    colors: colors,
                                    hintText: '+998',
                                    validator: (String? text) {
                                      if (text != null && text.length < 17) {
                                        return "number_entered_incorrectly"
                                            .tr();
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero)),
                                      onPressed: () {
                                        setState(() {
                                          hasSecondNumber = true;
                                        });
                                      },
                                      child: Text(
                                        "add_another_number".tr(),
                                        style: fonts.subtitle1
                                            .copyWith(color: colors.primary),
                                      )),
                                ),
                        ],
                      ),
                    16.verticalSpace,
                  ],
                ),
              );
            });
      });
    });
  }
}

class SmsVerificationDialog extends StatefulWidget {
  final String phoneNumber;
  final Function(String? code) onTap;

  const SmsVerificationDialog(
      {super.key, required this.phoneNumber, required this.onTap});

  @override
  State<SmsVerificationDialog> createState() => _SmsVerificationDialogState();
}

class _SmsVerificationDialogState extends State<SmsVerificationDialog>
    with CodeAutoFill {
  late TextEditingController _smsController;
  late SmsAutoFill smsAutoFill;

  late String codeValue;
  int refresh = 0;

  @override
  void initState() {
    _smsController = TextEditingController();
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
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "an_SMS_message_with_a_code_was_sent_to"
                  .tr(args: [widget.phoneNumber]),
              textAlign: TextAlign.center,
              style: fonts.subtitle2,
            ),
            SizedBox(height: 16.h),
            PinFieldAutoFill(
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
                  textStyle: fonts.headline2
                      .copyWith(fontSize: 32.sp, color: colors.customRed),
                  colorBuilder: FixedColorBuilder(colors.customGreyC3),
                ),
                onCodeChanged: (code) {
                  setState(() {
                    codeValue = code.toString();
                    if (codeValue.length == 6) {
                      widget.onTap(codeValue);
                    }
                  });
                }),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "cancel".tr(),
                  style: fonts.subtitle1,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
