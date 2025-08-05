import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/app/colors.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class ReviewDialogBody extends StatelessWidget {
  final String icon, title, subtitle;
  final String firstButtonName, secondButtonName;
  final VoidCallback firstButtonPressed, secondButtonPressed;
  final bool isError;
  const ReviewDialogBody({
    super.key,
    this.isError = false,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.firstButtonPressed,
    required this.secondButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Container(
          height: 156.h,
          width: 156.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !isError
                ? context.color.blueBackground.withValues(alpha: 0.1)
                : context.color.gradientRedOpacity.withValues(alpha: 0.1),
          ),
          child: icon.svg(
            height: 80.h,
            width: 80.h,
            color: !isError ? blue : red,
          ),
        ),
        ScreenUtil().setVerticalSpacing(26.h),
        Center(
          child: Text(
            title,
            style: Styles.boldTitle.copyWith(
              color: !isError
                  ? context.color.grey
                  : context.color.gradientRedOpacity,
              fontSize: 24.sp,
              fontFamily: Styles.gilroyMedium,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.descSubtitle.copyWith(
              color: context.color.grey,
              height: null,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: LongButton(
            buttonName: firstButtonName,
            onPress: firstButtonPressed,
          ),
        ),
        ScreenUtil().setVerticalSpacing(24.h),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          onPressed: secondButtonPressed,
          child: Text(
            secondButtonName,
            style: Styles.descSubtitle.copyWith(color: context.color.mainBlue),
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
      ],
    );
  }
}
