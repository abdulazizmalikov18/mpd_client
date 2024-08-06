import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/pages/doctor_profile_booking/presentation/widgets/dr_profile_info.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class LoadingDoctorInfo extends StatelessWidget {
  const LoadingDoctorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => const DrProfileInfoLoading(),
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(24.h),
        Container(
          height: 24.h,
          width: 102.w,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        Container(
          height: 85.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(10.r)),
        ),
      ],
    );
  }
}
