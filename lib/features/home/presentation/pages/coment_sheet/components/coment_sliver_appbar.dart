import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ComentSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback backPressed, morePressed;
  const ComentSliverAppBar({
    super.key,
    required this.title,
    required this.backPressed,
    required this.morePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 60.h,
      titleSpacing: 0,
      backgroundColor: context.color.white,
      title: Text(
        title,
        style: Styles.headline4.copyWith(color: context.color.black),
      ),
      floating: true,
      leading: IconButton(
        onPressed: backPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        icon: SvgPicture.asset(
          AppIcons.back,
          colorFilter: ColorFilter.mode(context.color.black, BlendMode.srcIn),
          height: 20.h,
          width: 20.h,
        ),
      ),
      actions: [
        IconButton(
          onPressed: morePressed,
          icon: SvgPicture.asset(
            AppIcons.moreIcon,
            colorFilter: ColorFilter.mode(context.color.black, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
