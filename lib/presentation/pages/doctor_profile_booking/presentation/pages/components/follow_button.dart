// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onTap;
  const FollowButton({
    super.key,
    required this.onTap,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: isFollowing ? white : mainBlue,
          side: const BorderSide(color: mainBlue),
          minimumSize: Size(136.w, 34.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
      onPressed: onTap,
      icon: SvgPicture.asset(
        isFollowing ? AppIcons.userTick : AppIcons.userAdd,
        height: 16.h,
        width: 16.h,
        color: isFollowing ? mainBlue : white,
      ),
      label: Text(
        isFollowing ? context.l10n.book_doctor_unfollow : context.l10n.book_doctor_follow,
        style: Styles.descSubtitle.copyWith(color: isFollowing ? mainBlue : white, fontSize: 12.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}


//label
