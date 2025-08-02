import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/src/widgets/w_shimmer.dart';

class WNetworkImage extends StatelessWidget {
  final String? image;
  final double height;
  final double width;
  final double borderRadius;
  final Widget defaultWidget;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final BoxFit fit;

  const WNetworkImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.errorBuilder,
    required this.defaultWidget,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: (image?.isNotEmpty ?? false)
          ? CachedNetworkImage(
              imageUrl: image!,
              height: height,
              width: width,
              fit: fit,
              errorWidget: (_, __, ___) {
                return defaultWidget;
              },
              progressIndicatorBuilder: (context, child, loadingProgress) {
                return WShimmer(
                  height: height,
                  width: width,
                  radius: borderRadius,
                );
              },
            )
          : defaultWidget,
    );
  }
}
