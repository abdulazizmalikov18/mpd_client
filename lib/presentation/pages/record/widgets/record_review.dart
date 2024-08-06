import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/json_html_coverter.dart';

class RecordReview extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isHtml;

  const RecordReview({
    super.key,
    required this.title,
    required this.subtitle,
    this.isHtml = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.boldTopHint.copyWith(fontSize: 16.sp, color: black),
          ),
          ScreenUtil().setVerticalSpacing(4.h),
          if (subtitle.isNotEmpty && subtitle[0] == "{")
            HtmlWidget(
              JsonToHTML(jsonDecode(subtitle)['document']['children'] as List).getHtml(),
              textStyle: const TextStyle(color: grey),
            )
          else
            Text(
              subtitle,
              style: Styles.descSubtitle.copyWith(color: grey, fontSize: 14.sp),
            )
        ],
      ),
    );
  }
}
