import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/introduction/data/models/tutorial_model.dart';
import 'package:mpd_client/src/themes/styles.dart';

class PageViewWidget extends StatelessWidget {
  final TutorialModel tutorial;
  const PageViewWidget({super.key, required this.tutorial});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 34.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SvgPicture.asset(tutorial.image),
          ),
        ),
        ScreenUtil().setVerticalSpacing(36.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            tutorial.title,
            textAlign: TextAlign.center,
            style: Styles.title
                .copyWith(color: context.color.black, letterSpacing: 1),
          ),
        ),
        ScreenUtil().setVerticalSpacing(16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            tutorial.subtitle,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Styles.descSubtitle.copyWith(color: context.color.grey),
          ),
        )
      ],
    );
  }
}
