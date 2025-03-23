import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/src/themes/styles.dart';

class SelectVariantsWidget extends StatelessWidget {
  final String hint;
  final String topHint;
  final VoidCallback onPressed;
  const SelectVariantsWidget({super.key, required this.hint, required this.topHint, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            topHint,
            style: Styles.boldTopHint.copyWith(color: context.color.black),
          ),
        ),
        ScreenUtil().setVerticalSpacing(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r), border: Border.all(color: context.color.border, width: 1)),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              visualDensity: VisualDensity(vertical: -2.5.h),
              title: Text(
                hint,
                style: Styles.headline7.copyWith(color: context.color.grey),
              ),
              trailing: SvgPicture.asset(
                AppIcons.arrowDown,
                colorFilter:  ColorFilter.mode(context.color.grey, BlendMode.srcIn),
                height: 24.h,
                width: 24.h,
              ),
              onTap: onPressed,
            ),
          ),
        )
      ],
    );
  }
}
