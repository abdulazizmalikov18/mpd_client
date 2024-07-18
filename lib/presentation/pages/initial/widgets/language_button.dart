import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class LaguageButton extends StatelessWidget {
  final String imagePath;
  final String language;
  final VoidCallback onPressed;

  const LaguageButton({super.key, required this.language, required this.onPressed, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: background,
        minimumSize: Size(358.w, 50.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onPressed: onPressed,
      icon: Image.asset(
        imagePath,
        height: 24.h,
        width: 24.h,
        fit: BoxFit.fill,
      ),
      label: Text(
        language,
        style: AppTheme.displayMedium.copyWith(
          color: black,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
    );
  }
}
