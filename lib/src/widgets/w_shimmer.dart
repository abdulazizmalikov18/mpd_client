import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';

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
      baseColor: const Color(0xFFF2F5F8),
      highlightColor: const Color(0xFFE1E4EA),
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 16),
          color: context.color.blueBackground,
        ),
      ),
    );
  }
}
