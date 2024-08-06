import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class ServiceLoading extends StatelessWidget {
  const ServiceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 9,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: mainBlue.withOpacity(0.2),
          highlightColor: mainBlue.withOpacity(0.4),
          child: Container(
            height: 72.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      },
    );
  }
}
