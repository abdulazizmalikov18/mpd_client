import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/cached_image_widget.dart';
import 'package:mpd_client/src/widgets/default_avatar.dart';

class ComentPostOwner extends StatelessWidget {
  final VoidCallback onPressed;
  final String fullname, job;
  final String? avatar;
  const ComentPostOwner(
      {super.key,
      required this.avatar,
      required this.fullname,
      required this.job,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      minLeadingWidth: 0,
      dense: true,
      horizontalTitleGap: 8.w,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: avatar!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: CachedImageWidget(url: avatar!, size: 40))
          : const DefaultAvatar(containerSize: 40, imageSize: 32),
      title: Text(
        fullname,
        style: Styles.postTitle.copyWith(fontFamily: Styles.gilroyRegular),
      ),
      subtitle: Text(job,
          style: Styles.postSubtitle.copyWith(fontFamily: Styles.gilroyLight)),
    );
  }
}
