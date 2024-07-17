import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/style.dart';
import '../styles/theme_wrapper.dart';
import 'animation_effect.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isDisabled;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.isDisabled = false,
    required this.title,
    this.verticalPadding,
    this.horizontalPadding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, _, __) {
        return OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => backgroundColor ?? Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: borderColor ?? Style.primary, width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h, horizontal: horizontalPadding ?? 42.w),
            child: Text(
              title,
              style: fonts.subtitle1.copyWith(color: textColor ?? colors.text),
            ),
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final bool isDisabled;
  final double borderWidth;
  final double verticalPadding;
  final double? horizontalPadding;
  final bool haveBorder;
  final bool isInfinityWidth;
  final Color? borderColor;
  final Widget? titleWidget;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.isDisabled = false,
    this.haveBorder = true,
    required this.title,
    this.titleStyle,
    this.titleColor = const Color(0xffFFFFFF),
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.verticalPadding = 12,
    this.horizontalPadding,
    this.isInfinityWidth = true,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, _, __, ___) {
      return AnimationButtonEffect(
        onTap: isDisabled ? null : onPressed,
        child: Container(
          width: isInfinityWidth ? double.infinity : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: haveBorder
                ? Border.all(
                    color: borderColor ?? (isDisabled ? colors.white : colors.primary),
                    width: borderWidth,
                  )
                : null,
            color: isDisabled ? backgroundColor?.withOpacity(0.5) ?? colors.primary.withOpacity(0.5) : backgroundColor ?? colors.primary,
            boxShadow: isDisabled ? null : const [],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding.h, horizontal: horizontalPadding ?? 8.w),
            child: titleWidget ??
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: titleStyle ??
                      Style.medium16(
                        size: 18.sp,
                        color: titleColor, // isDisabled ? colors.textV1 :
                      ),
                ),
          ),
        ),
      );
    });
  }
}
