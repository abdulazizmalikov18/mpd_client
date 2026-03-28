import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/core/utils/html_covertor.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/provider/language.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';

class RecordsCard extends StatelessWidget {
  final RecordModel record;
  final VoidCallback onPressed;
  const RecordsCard({super.key, required this.record, required this.onPressed});

  String _writerLine(BuildContext context) {
    final prefix = context.l10n.common_written_by;
    final w = record.writer;
    if (w == null) return '$prefix —';
    final parts = <String>[];
    if (w.name != null && w.name!.trim().isNotEmpty) parts.add(w.name!.trim());
    if (w.lastname != null && w.lastname!.trim().isNotEmpty) {
      parts.add(w.lastname!.trim());
    }
    if (parts.isEmpty) return '$prefix —';
    return '$prefix ${parts.join(' ')}';
  }

  @override
  Widget build(BuildContext context) {
    final preview = HtmlPlainText.toPlainPreview(record.conclusion);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: context.color.white,
          boxShadow: [
            BoxShadow(
              color: context.color.shadow.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 64.h,
                  width: 56.w,
                  margin: EdgeInsets.only(left: 14.w, top: 14.h, bottom: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      colors: [
                        context.color.gradientBlueOpacity,
                        context.color.gradientBlue,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${record.date!.day}\n',
                          style: Styles.boldTopHint.copyWith(
                            fontSize: 16.sp,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        TextSpan(
                          text: Utils.shortMonthName(
                            record.date!,
                            context,
                          ).toUpperCase(),
                          style: Styles.boldTopHint.copyWith(
                            fontSize: 11.sp,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 14.h, 14.w, 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.product ?? '--',
                          style: Styles.boldTopHint.copyWith(
                            fontSize: 16.sp,
                            height: 1.25,
                            color: context.color.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        ScreenUtil().setVerticalSpacing(6.h),
                        Text(
                          _writerLine(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.descSubtitle.copyWith(
                            color: context.color.mainBlue,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (preview.isNotEmpty) ...[
                          ScreenUtil().setVerticalSpacing(6.h),
                          Text(
                            preview,
                            style: Styles.cardReview.copyWith(
                              color: context.color.grey,
                              fontSize: 12.sp,
                              height: 1.35,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
