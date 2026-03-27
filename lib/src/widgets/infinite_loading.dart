import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/provider/language.dart';

class InfiniteLoadingWidget extends StatelessWidget {
  const InfiniteLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.h,
          width: 25.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: context.color.mainBlue,
          ),
        ),
        ScreenUtil().setHorizontalSpacing(10.w),
        Text(
          context.l10n.common_loading,
          style: Styles.headline7.copyWith(color: context.color.mainBlue),
        ),
      ],
    );
  }
}
