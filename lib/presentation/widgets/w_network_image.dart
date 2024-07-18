import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/widgets/w_shimmer.dart';

class WNetworkImage extends StatelessWidget {
  final String? image;
  final double height;
  final double width;
  final double borderRadius;
  final Widget defaultWidget;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const WNetworkImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.errorBuilder,
    required this.defaultWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: (image?.isNotEmpty ?? false)
          ? Image.network(
        image!,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: errorBuilder ??
                (_, __, ___) {
              return defaultWidget;
            },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return WShimmer(
              height: height,
              width: width,
              radius: borderRadius,
            );
          }
        },
      )
          : defaultWidget,
    );
  }
}
