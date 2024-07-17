import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PopularShimmerList extends StatelessWidget {
  const PopularShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 160.w,
              height: 180.h,
              margin: EdgeInsets.only(
                left: index == 0 ? 16.0.w : 8.w,
                right: index == 4 ? 16.0.w : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: colors.white,
                border: Border.all(color: colors.borderColor),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ShimmerView(
                    child: ShimmerContainer(height: 80.h),
                  ),
                  8.verticalSpace,
                  const Row(
                    children: [
                      ShimmerView(
                        forText: true,
                        child: ShimmerContainer(height: 12, width: 48),
                      ),
                      Spacer(),
                      ShimmerView(
                        forText: true,
                        child: ShimmerContainer(height: 12, width: 54),
                      ),
                    ],
                  ),
                  6.verticalSpace,
                  Divider(color: colors.customGreyC3, thickness: .4, height: 0),
                  6.verticalSpace,
                  ShimmerView(
                    forText: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerContainer(
                          height: 12,
                          width: double.maxFinite,
                        ),
                        4.verticalSpace,
                        const ShimmerContainer(
                          height: 12,
                          width: 86,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
