import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/widget_defaul_avatar.dart';

class EmptyUserFollowers extends StatelessWidget {
  const EmptyUserFollowers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenUtil().setVerticalSpacing(160.h),
          const DefaultAvatar(containerSize: 156, imageSize: 80, iconName: AppIcons.userAdd),
          ScreenUtil().setVerticalSpacing(24.h),
          Text('You are not following anyone yet', style: Styles.emptyboldTitle),
          ScreenUtil().setVerticalSpacing(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 56.w),
            child: Text('Follow doctors and avail their services easily',
                textAlign: TextAlign.center, style: Styles.descSubtitle.copyWith(color: grey)),
          )
        ],
      ),
    );
  }
}
