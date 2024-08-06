import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/domain/models/appointment/record_model.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/utils.dart';

class RecordsCard extends StatelessWidget {
  final RecordModel record;
  final VoidCallback onPressed;
  const RecordsCard({super.key, required this.record, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: white,
        elevation: 8,
        shadowColor: shadow,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onPressed,
          customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 64.h,
                width: 56.w,
                margin: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  gradient: const LinearGradient(
                    colors: [gradientBlueOpacity, gradientBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${record.date!.day}\n',
                        style: Styles.boldTopHint.copyWith(fontSize: 16.sp),
                      ),
                      TextSpan(
                        text: Utils.shortMonthName(record.date!, context).toUpperCase(),
                        style: Styles.boldTopHint.copyWith(fontSize: 16.sp),
                      )
                    ])),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.product ?? "--",
                    style: Styles.boldTopHint.copyWith(fontSize: 18.sp),
                  ),
                  ScreenUtil().setVerticalSpacing(6.h),
                  Text(
                    record.writer != null ? 'Written by ${record.writer!.name!}${record.writer!.lastname!}' : 'Written by Dr. Watamaniuk',
                    style: Styles.descSubtitle.copyWith(color: mainBlue, fontSize: 14.sp),
                  ),
                  ScreenUtil().setVerticalSpacing(6.h),
                  Text(
                    '${record.conclusionFile ?? ''} Prescription',
                    style: Styles.cardReview.copyWith(color: grey, fontSize: 12.sp),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
