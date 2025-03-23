import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFollowing extends StatelessWidget {
  const ShimmerFollowing({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.color.baseColor,
      highlightColor: context.color.highlightColor,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration:
            BoxDecoration(border: Border.all(color: context.color.white), borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            ScreenUtil().setVerticalSpacing(16.h),
            Row(
              children: [
                ScreenUtil().setHorizontalSpacing(16.w),
                Container(
                  height: 72.h,
                  width: 72.h,
                  decoration:  BoxDecoration(shape: BoxShape.circle, color: context.color.white),
                ),
                ScreenUtil().setHorizontalSpacing(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerContainer(size: Size(122, 16)),
                    ScreenUtil().setVerticalSpacing(4.h),
                    const ShimmerContainer(size: Size(145, 16)),
                    ScreenUtil().setVerticalSpacing(6.h),
                    const ShimmerContainer(size: Size(180, 16)),
                  ],
                )
              ],
            ),
            ScreenUtil().setVerticalSpacing(25.h),
             Divider(
              thickness: 0.5,
              height: 0,
              color: context.color.white,
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            Row(
              children: [
                ScreenUtil().setHorizontalSpacing(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerContainer(size: Size(67, 12)),
                    ScreenUtil().setVerticalSpacing(3.h),
                    const ShimmerContainer(size: Size(88, 18)),
                  ],
                ),
                const Spacer(),
                const ShimmerContainer(size: Size(112, 32)),
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
