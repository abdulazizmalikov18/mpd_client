import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFollowing extends StatelessWidget {
  const ShimmerFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration:
            BoxDecoration(border: Border.all(color: white), borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(16.h),
            Row(
              children: [
                ScreenUtil().setHorizontalSpacing(16.w),
                Container(
                  height: 72.h,
                  width: 72.h,
                  decoration:  const BoxDecoration(shape: BoxShape.circle, color: white),
                ),
                ScreenUtil().setHorizontalSpacing(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WShimmer(width:122, height: 16),
                    ScreenUtil().setVerticalSpacing(4.h),
                    const WShimmer(width:145, height: 16),

                    ScreenUtil().setVerticalSpacing(6.h),
                    const WShimmer(width:180, height: 16),
                  ],
                )
              ],
            ),
            ScreenUtil().setVerticalSpacing(25.h),
             const Divider(
              thickness: 0.5,
              height: 0,
              color: white,
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            Row(
              children: [
                ScreenUtil().setHorizontalSpacing(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WShimmer(width:67, height: 12),

                    ScreenUtil().setVerticalSpacing(3.h),
                    const WShimmer(width:88, height: 18),
                  ],
                ),
                const Spacer(),
                    const WShimmer(width:112, height: 32),
                ScreenUtil().setHorizontalSpacing(16.w),
              ],
            ),
            ScreenUtil().setVerticalSpacing(16.h),
          ],
        ),
      ),
    );
  }
}
