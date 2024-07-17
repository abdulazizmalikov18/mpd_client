import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

import '../styles/theme_wrapper.dart';

class CustomTextFieldPasswordwithIcon extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isEmail;
  final bool isPassword;
  final String? error;

  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  const CustomTextFieldPasswordwithIcon({
    super.key,
    this.controller,
    this.hintText = '',
    this.title = '',
    this.isPassword = true,
    this.isEmail = false,
    this.error,
    this.validator,
  });

  @override
  State<CustomTextFieldPasswordwithIcon> createState() =>
      _CustomTextFieldPasswordwithIconState();
}

class _CustomTextFieldPasswordwithIconState
    extends State<CustomTextFieldPasswordwithIcon> {
  bool isUnViziable = true;

  _changeVisibility() {
    setState(() {
      isUnViziable = !isUnViziable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title.isNotEmpty
              ? Text(
                  widget.title,
                  style: fonts.subtitle1.copyWith(
                    color: widget.error == null ? colors.text : colors.error,
                  ),
                )
              : Container(),
          widget.title.isNotEmpty ? SizedBox(height: 6.h) : Container(),
          SizedBox(
            child: TextFormField(
              controller: widget.controller,
              style:
                  fonts.subtitle1.copyWith(fontSize: 16.sp, color: colors.text),
              obscureText: widget.isPassword && isUnViziable,
              keyboardType: _getKeyboardType(),
              validator: widget.validator,
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 60.w,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      icons.passwordIc.svg(
                          width: 20.w, height: 20.h, color: colors.customRed),
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
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: _changeVisibility,
                        icon: isUnViziable
                            ? icons.eye.svg()
                            : icons.eyeSlash.svg(),
                      )
                    : null,
                // focusColor: Style.secondary,
                fillColor: colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: colors.customGreyC3, width: 1.w),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: colors.customGreyC3, width: 1.w),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: colors.customGreyC3, width: 1.w),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                hintText: widget.hintText,
                hintStyle: fonts.subtitle1.copyWith(
                    fontSize: 16.sp,
                    color: colors.customBlack.withOpacity(0.5)),
                errorText: widget.error,
                errorStyle: fonts.caption.copyWith(color: colors.error),
                contentPadding: EdgeInsets.all(15.sp),
              ),
            ),
          ),
        ],
      );
    });
  }

  TextInputType? _getKeyboardType() {
    if (widget.isEmail) {
      return TextInputType.emailAddress;
    } else if (widget.isPassword) {
      return TextInputType.visiblePassword;
    } else {
      return null;
    }
  }
}
