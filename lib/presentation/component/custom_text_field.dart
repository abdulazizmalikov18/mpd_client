import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/theme_wrapper.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String hintText;
  final String titleHintText;
  final bool isEmail;
  final bool isPassword;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onsuffixIconPressed;
  final void Function()? onprefixIconPressed;
  final void Function()? onPressed;
  final TextInputType keyboardType;
  final String? error;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatter;
  final TextAlign textAlign;
  final bool readOnly;
  final bool? expands;
  final double? borderWidth;
  final double? borderRadius;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? enableBorderColor;
  final InputBorder? border;
  final EdgeInsets? padding;
  final String? Function(String? value)? validator;
  final String? initialValue;

  const CustomTextField({
    super.key,
    this.onPressed,
    this.border,
    this.expands,
    this.enableBorderColor,
    this.onsuffixIconPressed,
    this.onprefixIconPressed,
    this.formatter,
    this.borderWidth = 1.5,
    this.borderRadius,
    this.fillColor,
    this.controller,
    this.hintText = '',
    this.title = '',
    this.subTitle = '',
    this.isPassword = false,
    this.minLines = 1,
    this.maxLines = 2,
    this.isEmail = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.obscureText = false,
    this.error,
    this.titleHintText = '',
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.padding,
    this.validator,
    this.initialValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, _) {
      return Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title.isNotEmpty
                ? Text(
                    widget.title,
                    style: fonts.subtitle1.copyWith(
                      color: widget.error == null ? colors.text : colors.error,
                    ),
                  )
                : const SizedBox(),
            widget.title.isNotEmpty ? SizedBox(height: 6.h) : const SizedBox(),
            widget.titleHintText.isNotEmpty
                ? Text(
                    widget.titleHintText,
                    style: fonts.caption.copyWith(
                      color: colors.grey,
                    ),
                  )
                : const SizedBox(),
            widget.titleHintText.isNotEmpty
                ? SizedBox(height: 6.h)
                : const SizedBox(),
            TextFormField(
              initialValue: widget.initialValue,
              expands: widget.expands ?? false,
              onTap: widget.onPressed,
              textInputAction: TextInputAction.done,
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              readOnly: widget.readOnly,
              textAlign: widget.textAlign,
              inputFormatters: widget.formatter,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              controller: widget.controller,
              style: fonts.bodyText2.copyWith(color: colors.text),
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              decoration: InputDecoration(
                counterText: widget.maxLength == 500 ? null : '',
                suffixIcon: widget.suffixIcon != null
                    ? IconButton(
                        icon: widget.suffixIcon!,
                        onPressed: widget.onsuffixIconPressed ?? () {})
                    : null,
                prefixIcon: widget.prefixIcon != null
                    ? IconButton(
                        icon: widget.prefixIcon!,
                        onPressed: widget.onprefixIconPressed ?? () {})
                    : null,
                focusColor: colors.secondary,
                fillColor: widget.fillColor ?? colors.transparent,
                hoverColor: colors.white,
                filled: true,
                border: widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: colors.primary, width: 1),
                    ),
                enabledBorder: widget.border ??
                    OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 10.r),
                      borderSide: BorderSide(
                          color: widget.enableBorderColor ?? colors.borderColor,
                          width: widget.borderWidth ?? 1),
                    ),
                focusedBorder: widget.border ??
                    OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 10.r),
                      borderSide: BorderSide(
                          color: colors.primary,
                          width: widget.borderWidth ?? 1),
                    ),
                hintText: widget.hintText,
                hintStyle: fonts.subtitle1.copyWith(
                    color: colors.customBlack.withOpacity(0.5),
                    fontSize: 14.sp),
                errorText: widget.error,
                errorStyle: fonts.caption.copyWith(color: colors.error),
                contentPadding:
                    EdgeInsets.only(left: 16.w, top: 12.h, right: 12.w),
              ),
            ),
            widget.subTitle.isNotEmpty
                ? SizedBox(height: 6.h)
                : const SizedBox(),
            widget.subTitle.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.subTitle,
                        style: fonts.bodyText1.copyWith(
                            color: widget.error == null
                                ? colors.bodyText
                                : colors.error,
                            fontSize: 12.sp),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
