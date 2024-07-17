import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NotificationsShimmerList extends StatelessWidget {
  const NotificationsShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          itemCount: 6,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: colors.colorF5F5F5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: ShimmerView(
                          child: ShimmerContainer(height: 150.h),
                        ),
                      ),
                      8.verticalSpace,
                      ShimmerView(
                        child: ShimmerContainer(height: 14.h, width: 250.w),
                      ),
                      6.verticalSpace,
                      ShimmerView(
                        child: ShimmerContainer(height: 12.h, width: 240.w),
                      ),
                      4.verticalSpace,
                      ShimmerView(
                        child: ShimmerContainer(height: 12.h, width: 120.w),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
