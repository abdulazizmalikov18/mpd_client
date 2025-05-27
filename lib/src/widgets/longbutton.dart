import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/core/platform/platform_check.dart';
import 'package:mpd_client/src/themes/styles.dart';

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
  final Widget? widget;
  final BoxBorder? border;

  const LongButton({
    super.key,
    this.buttonName = "",
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
    this.widget,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 6),
            color:
                (shadowColor ?? context.color.mainBlue).withValues(alpha: 0.1),
          )
        ],
        borderRadius: BorderRadius.circular(10.r),
        border: border,
        color: isDisable ? context.color.grey : color ?? mainBlue,
        // gradient: color == null
        //     ? LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           !isDisable
        //               ? (gradientOpacity ?? context.color.gradientBlueOpacity)
        //               : context.color.grey,
        //           !isDisable
        //               ? (gradient ?? context.color.gradientBlue)
        //               : context.color.grey,
        //         ],
        //       )
        //     : null,
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
      return widget ??
          Text(
            buttonName,
            style: Styles.boldHeadline6.copyWith(
              color: context.color.white,
              fontSize: fontsize,
            ),
          );
    }
    if (PlatformCheck.platform) {
      return Transform.scale(
        scale: 0.7,
        child: CupertinoActivityIndicator(
          radius: 15.r,
          color: context.color.white,
        ),
      );
    }
    return Transform.scale(
      scale: 0.6,
      child: CircularProgressIndicator(
        color: context.color.white,
      ),
    );
  }
}
