import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:shimmer/shimmer.dart';


class WShimmer extends StatelessWidget {
  const WShimmer({
    super.key,
    this.width,
    this.height,
    this.radius,
  });

  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF3E80FF).withOpacity(.15),
      highlightColor: const Color(0xFF3E80FF).withOpacity(.25),
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 12),
          color: white,
        ),
      ),
    );
  }
}
