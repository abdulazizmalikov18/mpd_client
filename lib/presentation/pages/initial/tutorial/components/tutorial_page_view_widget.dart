import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/domain/models/tutorial_model.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

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
            style: AppTheme.headlineSmall.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            tutorial.subtitle,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.headlineSmall.copyWith(
              fontSize: 17,
              color: grey,
            ),
          ),
        )
      ],
    );
  }
}
