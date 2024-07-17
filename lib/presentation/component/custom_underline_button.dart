import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class CustomUnderlineTextButton extends StatelessWidget {
  const CustomUnderlineTextButton({
    super.key,
    required this.colors,
    required this.fonts,
    required this.text,
    required this.onPressed,
    this.fontSize = 16,
  });
  final CustomColorSet colors;
  final FontSet fonts;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: colors.customBlack.withOpacity(0.7),
          textStyle: fonts.subtitle1.copyWith(
            fontSize: 16.sp,
            decoration: TextDecoration.underline,
          ),
          minimumSize: Size(50, 22.h),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
