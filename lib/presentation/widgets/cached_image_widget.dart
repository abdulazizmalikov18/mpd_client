import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';
import 'package:shimmer/shimmer.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double size;
  const CachedImageWidget({super.key, required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return DefaultAvatar(containerSize: size.h, imageSize: size.h - 16);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size.h - 16),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        height: size.h,
        width: size.h,
        errorWidget: (context, url, error) => DefaultAvatar(containerSize: size.h, imageSize: size.h - 16),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: const Material(color: white),
        ),
      ),
    );
  }
}
