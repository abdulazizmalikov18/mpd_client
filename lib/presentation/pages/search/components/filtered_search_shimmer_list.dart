import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/shimmer_view.dart';

class FilteredSearchSimmerList extends StatelessWidget {
  const FilteredSearchSimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ShimmerView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShimmerContainer(height: 26.h, width: 26.w),
                  16.horizontalSpace,
                  ShimmerContainer(height: 60.h, width: 70.w),
                  12.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(height: 14.h, width: 84.w),
                      8.verticalSpace,
                      ShimmerContainer(height: 14.h, width: 124.w),
                      8.verticalSpace,
                      ShimmerContainer(height: 14.h, width: 64.w),
                    ],
                  ),
                  const Spacer(),
                  ShimmerContainer(
                    height: 26.r,
                    width: 26.r,
                    borderRadius: 50,
                  ),
                  16.horizontalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
