import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mpd_client/core/utils/html_covertor.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/app_export.dart';
import '../../../../src/themes/styles.dart';

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
          color: context.color.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.boldTopHint
                .copyWith(fontSize: 16.sp, color: context.color.black),
          ),
          ScreenUtil().setVerticalSpacing(4.h),
          if (subtitle.isNotEmpty && subtitle[0] == '{')
            HtmlWidget(
              JsonToHTML(jsonDecode(subtitle)['document']['children'] as List)
                  .getHtml(),
              textStyle: TextStyle(color: context.color.grey),
            )
          else if (subtitle.isNotEmpty &&
              (subtitle.contains("<div") || subtitle.contains("<p")))
            HtmlWidget(
              subtitle,
              textStyle: TextStyle(color: context.color.grey),
            )
          else
            Text(
              subtitle,
              style: Styles.descSubtitle.copyWith(
                color: context.color.grey,
                fontSize: 14.sp,
              ),
            )
        ],
      ),
    );
  }
}
