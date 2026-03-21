import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/user/data/models/user_records_model.dart';
import 'package:mpd_client/provider/language.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';

class RecordsCard extends StatelessWidget {
  final RecordModel record;
  final VoidCallback onPressed;
  const RecordsCard({super.key, required this.record, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        elevation: 8,
        shadowColor: context.color.shadow,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 64.h,
                width: 56.w,
                margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
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
                        style: Styles.boldTopHint.copyWith(fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: Utils.shortMonthName(
                          record.date!,
                          context,
                        ).toUpperCase(),
                        style: Styles.boldTopHint.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.product ?? "--",
                      style: Styles.boldTopHint.copyWith(fontSize: 18.sp),
                      maxLines: 1,
                    ),
                    ScreenUtil().setVerticalSpacing(6.h),
                    Text(
                      record.writer != null
                          ? '${context.l10n.common_written_by} ${record.writer!.name!}${record.writer!.lastname!}'
                          : '${context.l10n.common_written_by} Dr. Watamaniuk',
                      maxLines: 1,
                      style: Styles.descSubtitle.copyWith(
                        color: context.color.mainBlue,
                        fontSize: 14.sp,
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(6.h),
                    Text(
                      '${record.conclusionFile ?? ''} ${context.l10n.common_prescription}',
                      style: Styles.cardReview.copyWith(
                        color: context.color.grey,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
