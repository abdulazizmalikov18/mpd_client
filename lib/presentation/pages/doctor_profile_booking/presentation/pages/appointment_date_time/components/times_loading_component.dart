import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class TimesLoadingComponent extends StatelessWidget {
  const TimesLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 9,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 55, childAspectRatio: 1 / 2.9, mainAxisSpacing: 11.5.w, crossAxisSpacing: 12.h),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: white,
              ),
            ),
          );
        });
  }
}
