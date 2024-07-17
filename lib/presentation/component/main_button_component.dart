import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class MainButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsets? margin;
  final bool isLoading;
  final Widget? child;
  final Widget? childAfter;

  const MainButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.fontSize,
    this.margin,
    this.child,
    this.isLoading = false,
    this.childAfter,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, controller) {
        return GestureDetector(
          onTap: isLoading ? () {} : onPressed,
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 56.h,
            margin: margin,
            decoration: BoxDecoration(
              border: Border.all(
                color: backgroundColor == Colors.transparent
                    ? borderColor ?? colors.firstColor
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20.r),
              color: backgroundColor ?? colors.primary,
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        child ?? const SizedBox(),
                        child != null
                            ? SizedBox(
                                width: 8.w,
                              )
                            : const SizedBox(),
                        Text(
                          text,
                          style: fonts.bodyText1.copyWith(
                              fontSize: fontSize ?? 16.sp,
                              color: textColor ?? colors.white),
                        ),
                        childAfter != null
                            ? SizedBox(
                                width: 8.w,
                              )
                            : const SizedBox(),
                        childAfter ?? const SizedBox(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
