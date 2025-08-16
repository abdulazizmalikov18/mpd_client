// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';

class UserTileWigdet extends StatelessWidget {
  final bool disabled;
  final String appIcon;
  final String title;
  final String trailing;
  final Color? titleColor;
  final VoidCallback? onTap;
  const UserTileWigdet({
    super.key,
    required this.appIcon,
    required this.title,
    this.titleColor,
    this.trailing = '',
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: onTap,
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              appIcon,
              height: 24.h,
              width: 24.h,
              color: !disabled
                  ? (titleColor ?? context.color.black)
                  : (titleColor ?? context.color.black).withValues(alpha: 0.5),
            ),
            ScreenUtil().setHorizontalSpacing(16),
            Text(
              title,
              style: Styles.descSubtitle.copyWith(
                color: !disabled
                    ? (titleColor ?? context.color.black)
                    : (titleColor ?? context.color.black).withValues(
                        alpha: 0.5,
                      ),
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            Text(
              trailing,
              style: Styles.descSubtitle.copyWith(
                color: !disabled
                    ? context.color.mainBlue
                    : context.color.mainBlue.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
