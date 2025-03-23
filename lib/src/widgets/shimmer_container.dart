import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';

class ShimmerContainer extends StatelessWidget {
  final Size size;
  final double radius;
  const ShimmerContainer({super.key, required this.size, this.radius = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height.h,
      width: size.width.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius.r), color: context.color.white),
    );
  }
}
