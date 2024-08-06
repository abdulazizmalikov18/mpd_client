import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';

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
      height: 114.h,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 64.h,
            width: 64.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: mainBlue.withOpacity(0.1)),
            child: GradientIcon(
              iconName: iconName,
              size: 24,
            ),
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Text(
            count.toString(),
            style: Styles.descSubtitle.copyWith(color: mainBlue, fontWeight: FontWeight.w500),
          ),
          ScreenUtil().setVerticalSpacing(2.h),
          Text(
            label,
            style: Styles.bottomLabel.copyWith(color: black),
          )
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: white),
          ),
          ScreenUtil().setVerticalSpacing(10.h),
          Container(
            height: 19.h,
            width: 75.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: white),
          ),
          ScreenUtil().setVerticalSpacing(2.h),
          Container(
            height: 14.h,
            width: 75.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: white),
          ),
        ],
      ),
    );
  }
}
