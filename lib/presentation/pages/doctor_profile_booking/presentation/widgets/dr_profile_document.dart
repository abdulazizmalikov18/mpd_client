import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/theme.dart';


class DrProfileDocument extends StatelessWidget {
  final String title;
  final String iconName;
  final VoidCallback onPressed;
  const DrProfileDocument({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      horizontalTitleGap: 10.w,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Image.asset(iconName, height: 48.h, width: 48.h),
      title: Text(title, style: Styles.boldHeadline6),
    );
  }
}
