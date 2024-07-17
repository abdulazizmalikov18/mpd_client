import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  final TextEditingController controller;
  final String icons;
  final CustomColorSet colors;
  final Function(String) onChanged;
  final Function()? onTap;

  final String? hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool hasSuffixIcon;
  final bool autoFocus;

  const CustomTextFieldWithIcon({
    super.key,
    this.keyboardType = TextInputType.phone,
    required this.controller,
    required this.onChanged,
    required this.icons,
    this.inputFormatters,
    required this.colors,
    this.hintText,
    this.validator,
    this.readOnly = false,
    this.hasSuffixIcon = false,
    this.autoFocus = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icon, ctr) {
      return TextFormField(
        onTap: onTap,
        autofocus: autoFocus,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        inputFormatters: inputFormatters,
        validator: validator,
        readOnly: readOnly,
        style: Style.medium14(size: 16.sp, color: colors.text),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Style.medium14().copyWith(
              fontSize: 16.sp, color: colors.customBlack.withOpacity(0.5)),
          prefixIcon: SizedBox(
            width: 60.w,
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                SvgPicture.asset(
                  icons,
                  width: 20.w,
                  height: 20.h,
                ),
                SizedBox(
                  height: 22.h,
                  child: VerticalDivider(
                    color: colors.customGreyC3,
                    thickness: 1.w,
                    width: 22.w,
                  ),
                ),
              ],
            ),
          ),
          suffixIcon: hasSuffixIcon
              ? Padding(
                  padding: const EdgeInsets.all(14),
                  child: icon.down.svg(
                    color: colors.customGreyC3,
                  ),
                )
              : null,
          filled: true,
          fillColor: colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.customGreyC3, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.customGreyC3, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          contentPadding: EdgeInsets.all(15.sp),
        ),
      );
    });
  }
}
