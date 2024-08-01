import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class IconGradientButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final double height, width;

  const IconGradientButton({super.key, required this.icon, required this.onPressed, this.height = 50, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(blurRadius: 10, offset: const Offset(0, 6), color: mainBlue.withOpacity(0.1))],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientBlueOpacity, gradientBlue],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.zero,
          foregroundColor: Colors.white30,
          backgroundColor: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
          child: SvgPicture.asset(icon, colorFilter:  const ColorFilter.mode(white, BlendMode.srcIn)),
        ),
      ),
    );
  }
}
