import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

SliderThemeData customSliserThemeData(CustomColorSet colors) {
  return SliderThemeData(
    trackHeight: 2.h,
    thumbColor: colors.searchTextfieldColor,
    activeTrackColor: colors.customRed,
    disabledThumbColor: colors.customGreyC3,
    rangeThumbShape: RoundRangeSliderThumbShape(
      enabledThumbRadius: 14.r,
    ),
    rangeTickMarkShape: RoundRangeSliderTickMarkShape(tickMarkRadius: 0.r),
    trackShape: const RectangularSliderTrackShape(),
    rangeTrackShape: const RectangularRangeSliderTrackShape(),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
  );
}

class MilleageTextFormField extends StatelessWidget {
  const MilleageTextFormField({
    super.key,
    required TextEditingController controller,
    required this.fonts,
    required this.colors,
    required this.hintText,
    this.suffixText,
    this.textAlign,
    this.onChanged,
  }) : _maxController = controller;

  final TextEditingController _maxController;
  final FontSet fonts;
  final CustomColorSet colors;
  final String hintText;
  final String? suffixText;
  final TextAlign? textAlign;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 14,
      controller: _maxController,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [CurruncyInputFormatter()],
      decoration: InputDecoration(
        hintText: hintText,
        suffixText: suffixText != null ? "(${(suffixText ?? "")})" : null,
        hintStyle: fonts.subtitle1.copyWith(
            fontSize: 13.sp, color: colors.customBlack.withOpacity(0.7)),
        suffixStyle: fonts.subtitle1.copyWith(
          fontSize: 13.sp,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.customGreyC3,
            width: 1.w,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.customGreyC3,
            width: 1.w,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_some_text'.tr();
        }
        return null;
      },
    );
  }
}
