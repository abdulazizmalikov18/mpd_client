import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class AppointmentPlaceDate extends StatelessWidget {
  final VoidCallback onPress;

  final String placeName;
  final String date;
  final String time;

  const AppointmentPlaceDate({
    super.key,
    required this.onPress,
    required this.placeName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.appointment_time_and_place,
                  style: Styles.boldHeadline6.copyWith(
                    color: black,
                  ),
                ),
                ScreenUtil().setVerticalSpacing(12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientIcon(
                      iconName: AppIcons.dateCalendar,
                      size: 18,
                    ),
                    ScreenUtil().setHorizontalSpacing(8.w),
                    Text(
                      date,
                      style: Styles.boldHeadline6.copyWith(fontSize: 14.sp, color: grey),
                    ),
                  ],
                ),
                ScreenUtil().setVerticalSpacing(12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientIcon(
                      iconName: AppIcons.clock,
                      size: 18,
                    ),
                    ScreenUtil().setHorizontalSpacing(8.w),
                    Text(
                      time,
                      style: Styles.descSubtitle.copyWith(fontSize: 14.sp, color: grey),
                    ),
                  ],
                ),
                ScreenUtil().setVerticalSpacing(12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientIcon(
                      iconName: AppIcons.location,
                      size: 18,
                    ),
                    ScreenUtil().setHorizontalSpacing(8.w),
                    Text(
                      placeName,
                      style: Styles.descSubtitle.copyWith(fontSize: 14.sp, color: grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
                onPressed: onPress,
                child: Text(
                  context.l10n.appointment_get_direction,
                  style: Styles.descSubtitle.copyWith(color: mainBlue, fontSize: 14.sp),
                ),
              ))
        ],
      ),
    );
  }
}
