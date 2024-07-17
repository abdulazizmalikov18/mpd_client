import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomTextFieldComp extends StatelessWidget {
  const CustomTextFieldComp({
    super.key,
    this.label,
    this.type,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.trailingIcon = false,
    this.onTapTrailingIcon,
    this.inputFormatters,
    this.initialValue,
  });

  final String? label;
  final TextInputType? type;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final bool trailingIcon;
  final VoidCallback? onTapTrailingIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, _) {
      return TextFormField(
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        keyboardType: type,
        cursorColor: colors.customGreyC3,
        decoration: InputDecoration(
          suffixIcon: trailingIcon
              ? IconButton(
                  onPressed: onTapTrailingIcon,
                  icon: icons.edit.svg(color: colors.text, height: 16),
                )
              : null,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: colors.customGreyC3,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: colors.customGreyC3,
          )),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
            color: colors.customGreyC3,
          )),
          label: Text(
            label ?? '',
            textAlign: TextAlign.center,
            style: fonts.headline1
                .copyWith(color: colors.text.withOpacity(0.7), fontSize: 12.sp),
          ),
        ),
      );
    });
  }
}
