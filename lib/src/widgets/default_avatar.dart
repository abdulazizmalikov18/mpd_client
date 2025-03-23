import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';

class DefaultAvatar extends StatelessWidget {
  final double containerSize, imageSize;
  final String iconName;

  const DefaultAvatar(
      {super.key,
      required this.containerSize,
      required this.imageSize,
      this.iconName = AppIcons.avatarDefault});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: containerSize.h,
      width: containerSize.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.color.mainBlue.withValues(alpha: 0.1),
      ),
      child: iconName.svg(
          width: imageSize, height: imageSize, color: context.color.mainBlue),
    );
  }
}
