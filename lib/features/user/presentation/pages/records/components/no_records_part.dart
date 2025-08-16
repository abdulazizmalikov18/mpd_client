import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class NoRecordsPart extends StatelessWidget {
  const NoRecordsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/notRecords.png',
            height: 130.h,
            fit: BoxFit.contain,
          ),
          ScreenUtil().setVerticalSpacing(23.h),
          Text(
            context.l10n.records_not_found,
            style: Styles.boldTopHint.copyWith(fontSize: 22),
          ),
          ScreenUtil().setVerticalSpacing(8.h),
          Text(
            context.l10n.records_not_found_description,
            textAlign: TextAlign.center,
            style: Styles.descSubtitle.copyWith(color: context.color.grey),
          ),
          ScreenUtil().setVerticalSpacing(32.h),
        ],
      ),
    );
  }
}
