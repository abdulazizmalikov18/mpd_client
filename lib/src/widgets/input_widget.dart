import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/themes/styles.dart';

class InputWidget extends StatelessWidget {
  final Color? background;
  final TextEditingController? controller;
  final bool obscure, hasFormatter;
  final String hintText;
  final Widget? suffixIcon;
  final ValueChanged? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextStyle? style;
  final double leftPadding;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool readOnly;
  final List<TextInputFormatter>? inputformater;
  final int? maxLength, maxLines;
  final AutovalidateMode? autovalidateMode;
  const InputWidget({
    super.key,
    this.autovalidateMode,
    this.controller,
    this.maxLines = 1,
    this.obscure = false,
    this.hasFormatter = false,
    this.leftPadding = 15,
    this.style,
    this.textInputAction,
    this.textInputType,
    this.maxLength,
    this.inputformater,
    this.textCapitalization = TextCapitalization.words,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.errorText,
    this.background ,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color:( background ?? context.color.white)),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        keyboardType: textInputType,
        readOnly: readOnly,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        obscureText: obscure,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        inputFormatters: inputformater ?? inputFormatter,
        style: style,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: prefixIcon(context),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(left: leftPadding),
          enabledBorder: Decorations.enabledBorder(context),
          focusedBorder: Decorations.focusedBorder(context),
          border: Decorations.enabledBorder(context),
          errorBorder: Decorations.errorBorder(context),
          errorText: errorText,
          hintText: hintText,
          hintStyle: Styles.descSubtitle.copyWith(color: context.color.grey),
        ),
      ),
    );
  }

  List<TextInputFormatter>? get inputFormatter => hasFormatter
      ? [
          MaskTextInputFormatter(mask: '+998 (##) ###-##-##', filter: {"#": RegExp(r'[0-9]')})
        ]
      : null;

  Widget? prefixIcon(BuildContext context) => hasFormatter
      ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScreenUtil().setHorizontalSpacing(15.w),
            Text('+998', style: Styles.headline7.copyWith(color: context.color.grey)),
            ScreenUtil().setHorizontalSpacing(10.w),
            Container(height: 19.h, width: 1, color: context.color.grey),
            ScreenUtil().setHorizontalSpacing(10.w),
          ],
        )
      : null;
}
