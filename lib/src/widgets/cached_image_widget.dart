import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double size;
  const CachedImageWidget({super.key, required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return DefaultAvatar(
        containerSize: size.h,
        imageSize: size.h - 16,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        height: size.h,
        width: size.h,
        errorWidget: (context, url, error) =>
            DefaultAvatar(containerSize: size.h, imageSize: size.h - 16),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: context.color.baseColor,
          highlightColor: context.color.highlightColor,
          child: Material(color: context.color.white),
        ),
      ),
    );
  }
}
