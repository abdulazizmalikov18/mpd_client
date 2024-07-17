import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class PinPutComponent extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final void Function(String value) onChanged;

  const PinPutComponent({
    super.key,
    required this.controller,
    this.validator,
    this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, GlobalController gridController) {
        return Pinput(
          autofocus: true,
          length: 6,
          defaultPinTheme: PinTheme(
            height: 50.h,
            width: 40.w,
            textStyle: fonts.headline2
                .copyWith(fontSize: 34.sp, color: colors.customRed),
            decoration: BoxDecoration(
                // color: colors.white,
                // borderRadius: BorderRadius.circular(10),
                border: Border(
              bottom: BorderSide(
                width: 3.h,
                color: colors.customGreyC3,
              ),
            )),
          ),
          keyboardType: TextInputType.number,
          focusNode: FocusNode(),
          controller: controller,
          pinAnimationType: PinAnimationType.scale,
          validator: validator,
          errorText: errorText,
          forceErrorState: true,
          errorTextStyle: fonts.headline2
              .copyWith(fontSize: 34.sp, color: colors.customRed),
          onChanged: onChanged,
        );
      },
    );
  }
}
