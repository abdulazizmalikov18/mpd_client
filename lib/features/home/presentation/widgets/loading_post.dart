import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPost extends StatelessWidget {
  const LoadingPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.color.baseColor,
      highlightColor: context.color.highlightColor,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        height: 680.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: context.color.cardShadow, blurRadius: 20.r),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.color.white,
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.h,
                        width: 107.w,
                        decoration: BoxDecoration(
                          color: context.color.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(2.h),
                      Container(
                        height: 14.h,
                        width: 71.w,
                        decoration: BoxDecoration(
                          color: context.color.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(2.h),
                      Container(
                        height: 14.h,
                        width: 71.w,
                        decoration: BoxDecoration(
                          color: context.color.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ScreenUtil().setVerticalSpacing(8.h),
            Container(height: 460.h, color: context.color.white),
            ScreenUtil().setVerticalSpacing(12.h),
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: context.color.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 40.h,
                  width: 58.w,
                  decoration: BoxDecoration(
                    color: context.color.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ),
            ScreenUtil().setVerticalSpacing(12.h),
            Container(
              height: 64.h,
              decoration: BoxDecoration(
                color: context.color.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
