import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class RecentlyShimmerList extends StatelessWidget {
  const RecentlyShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 110.h,
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: colors.white,
                border: Border.all(color: colors.borderColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ShimmerView(
                      child: ShimmerContainer(height: 110.h),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              ShimmerView(
                                child: ShimmerContainer(height: 12, width: 42),
                              ),
                              Spacer(),
                              ShimmerView(
                                child: ShimmerContainer(height: 12, width: 54),
                              ),
                            ],
                          ),
                          6.verticalSpace,
                          Divider(
                            color: colors.customGreyC3,
                            height: 0,
                            thickness: .4,
                          ),
                          6.verticalSpace,
                          ShimmerView(
                            child: ShimmerContainer(height: 14, width: 180.w),
                          ),
                          8.verticalSpace,
                          ShimmerView(
                            child: ShimmerContainer(height: 12, width: 180.w),
                          ),
                          4.verticalSpace,
                          ShimmerView(
                            child: ShimmerContainer(height: 12, width: 170.w),
                          ),
                          4.verticalSpace,
                          ShimmerView(
                            child: ShimmerContainer(height: 12, width: 140.w),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
