import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/themes/styles.dart';

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
        backgroundColor: context.color.background,
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
        style: Styles.boldHeadline6.copyWith(color: context.color.black),
      ),
    );
  }
}
