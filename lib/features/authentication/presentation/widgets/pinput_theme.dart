import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:pinput/pinput.dart';

class PinPutThemes {
  static PinTheme defaultPinPutTheme(BuildContext context) => PinTheme(
    textStyle: Styles.boldTitle.copyWith(color: context.color.black),
    width: 52.w,
    height: 62.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(width: 1.w, color: context.color.border),
    ),
  );
  static PinTheme submittedPinPutTheme(BuildContext context) => PinTheme(
    textStyle: Styles.boldTitle.copyWith(color: context.color.black),
    width: 52.w,
    height: 62.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(width: 1.w, color: context.color.mainBlue),
    ),
  );

  static PinTheme errorPinPutTheme(BuildContext context) => PinTheme(
    textStyle: Styles.boldTitle.copyWith(color: context.color.black),
    width: 52.w,
    height: 62.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(width: 1.w, color: context.color.red),
    ),
  );
}
