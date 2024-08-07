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
            boxShadow: const [
              BoxShadow(
                color: cardShadow,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 359.h,
              height: 175.h,
              decoration: const BoxDecoration(
                color: black,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        );
      },
    );
  }
}
