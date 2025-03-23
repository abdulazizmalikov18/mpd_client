import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

class ComentLoading extends StatelessWidget {
  const ComentLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: context.color.baseColor,
        highlightColor: context.color.highlightColor,
        child: Column(
          children: List.generate(
            5,
            (index) => Column(
              children: [
                ScreenUtil().setVerticalSpacing(16.h),
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration:  BoxDecoration(shape: BoxShape.circle, color: context.color.white),
                    ),
                    ScreenUtil().setHorizontalSpacing(10.w),
                    const ShimmerContainer(size: Size(113, 20)),
                  ],
                ),
                ScreenUtil().setVerticalSpacing(8.h),
                const ShimmerContainer(size: Size(double.maxFinite, 14)),
                ScreenUtil().setVerticalSpacing(4.h),
                const ShimmerContainer(size: Size(double.maxFinite, 14)),
              ],
            ),
          ),
        ));
  }
}
