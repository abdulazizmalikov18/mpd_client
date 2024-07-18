import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class LongButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPress;
  final bool loading, isDisable;
  final Color? gradientOpacity;
  final Color? gradient;
  final Color? color;
  final Color? shadowColor;
  final double height;
  final double width;
  final double fontsize;

  const LongButton({
    super.key,
    required this.buttonName,
    required this.onPress,
    this.fontsize = 16,
    this.shadowColor,
    this.gradient,
    this.color,
    this.gradientOpacity,
    this.loading = false,
    this.isDisable = false,
    this.height = 48,
    this.width = double.maxFinite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 10, offset: const Offset(0, 6), color: (shadowColor ?? mainBlue).withOpacity(0.1))],
        borderRadius: BorderRadius.circular(10.r),
        color: color,
        gradient: color == null
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  !isDisable ? (gradientOpacity ?? gradientBlueOpacity) : grey,
                  !isDisable ? (gradient ?? gradientBlue) : grey,
                ],
              )
            : null,
      ),
      child: TextButton(
        onPressed: isDisable ? null : onPress,
        style: TextButton.styleFrom(
          enableFeedback: false,
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: _widget(context),
      ),
    );
  }

  Widget _widget(BuildContext context) {
    if (!loading) {
      return Text(buttonName,
          style: AppTheme.headlineSmall.copyWith(
            color: white,
            fontSize: fontsize,
          ));
    }
    if (Platform.isIOS) {
      return Transform.scale(
        scale: 0.7,
        child: CupertinoActivityIndicator(
          radius: 15.r,
          color: white,
        ),
      );
    }
    return Transform.scale(
      scale: 0.6,
      child: const CircularProgressIndicator(
        color: white,
      ),
    );
  }
}
