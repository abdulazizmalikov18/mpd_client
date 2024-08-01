import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class AppointmentShimmer extends StatelessWidget {
  const AppointmentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: white,
            boxShadow: [BoxShadow(color: cardShadow, blurRadius: 20, offset: const Offset(0, 0))],
          ),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 359.h,
              height: 175.h,
              decoration: const BoxDecoration(color: black, borderRadius: BorderRadius.all(Radius.circular(12))),
            ),
            // child: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 72.h,
            //             width: 72.h,
            //             decoration: const BoxDecoration(
            //                 color: black, shape: BoxShape.circle),
            //           ),
            //           ScreenUtil().setHorizontalSpacing(16.w),
            //           Column(
            //             children: [
            //               const ShimmerContainer(size: Size(118, 21)),
            //               ScreenUtil().setVerticalSpacing(2.h),
            //               const ShimmerContainer(size: Size(100, 17)),
            //               ScreenUtil().setVerticalSpacing(6.h),
            //               const ShimmerContainer(size: Size(122, 14)),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //     ScreenUtil().setVerticalSpacing(16.h),
            //     Divider(
            //       height: 1.h,
            //       color: dividerColor,
            //     ),
            //     ScreenUtil().setVerticalSpacing(12.h),
            //     Padding(
            //       padding: EdgeInsets.only(left: 16.w, right: 16.w),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           ShimmerContainer(size: Size(126.w, 34.h)),
            //           ShimmerContainer(size: Size(112.w, 34.h))
            //         ],
            //       ),
            //     ),
            //     ScreenUtil().setVerticalSpacing(16.h),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}
