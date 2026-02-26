import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_icons.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_export.dart';
import '../../../../src/themes/styles.dart';

class DrProfileInfo extends StatelessWidget {
  final String iconName;
  final int count;
  final String label;
  const DrProfileInfo({
    super.key,
    required this.iconName,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 64.h,
            width: 64.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.mainBlue.withValues(alpha: 0.1),
            ),
            child: iconName.svg(
              width: 24,
              height: 24,
              color: context.color.mainBlue,
            ),
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Text(
            count.toString(),
            style: Styles.descSubtitle.copyWith(
              color: context.color.mainBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          ScreenUtil().setVerticalSpacing(2.h),
          Text(
            label,
            style: Styles.bottomLabel.copyWith(color: context.color.black),
          ),
        ],
      ),
    );
  }
}

class DrProfileInfoLoading extends StatelessWidget {
  const DrProfileInfoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 64.h,
            width: 64.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.color.white,
            ),
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Container(
            height: 19.h,
            width: 75.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: context.color.white,
            ),
          ),
          ScreenUtil().setVerticalSpacing(2.h),
          Container(
            height: 14.h,
            width: 75.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: context.color.white,
            ),
          ),
        ],
      ),
    );
  }
}
