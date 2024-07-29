import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class FilledGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget text;
  final double height;
  final bool isDisable;
  const FilledGradientButton({super.key, this.isDisable = false, required this.onPressed, required this.text, this.height = 34});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            isDisable ? grey : gradientBlueOpacity,
            isDisable ? grey : gradientBlue,
          ]),
          borderRadius: BorderRadius.circular(8.r)),
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
        child: text,
      ),
    );
  }
}
