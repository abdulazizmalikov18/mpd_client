import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class IconCircleButton extends StatelessWidget {
  final String icon;
  final Size size;
  final bool isCircle;
  final Color? color;
  final VoidCallback onPressed;
  final Color? iconColor;

  const IconCircleButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.isCircle = true,
    this.size = const Size(48, 48),
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      enableFeedback: false,
      onPressed: onPressed,
      color: color ?? white,
      shape: isCircle ? const CircleBorder() : null,
      height: size.height.h,
      minWidth: size.width.h,
      child: SvgPicture.asset(
        icon,
        colorFilter: iconColor == null ? null : ColorFilter.mode(iconColor!, BlendMode.srcIn),
      ),
    );
  }
}
