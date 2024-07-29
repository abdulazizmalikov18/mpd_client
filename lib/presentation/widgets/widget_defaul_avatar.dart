import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';

class DefaultAvatar extends StatelessWidget {
  final double containerSize, imageSize;
  final String iconName;

  const DefaultAvatar({super.key, required this.containerSize, required this.imageSize, this.iconName = AppIcons.avatarDefault});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: containerSize.h,
      width: containerSize.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainBlue.withOpacity(0.1),
      ),
      child: GradientIcon(iconName: iconName, size: imageSize),
    );
  }
}
