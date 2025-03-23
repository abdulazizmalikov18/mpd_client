import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/transparent_long_button.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';
import '../../../../../../src/widgets/bottom_sheet_widget.dart';

class DisabledAccount extends StatelessWidget {
  final VoidCallback onPress;
  const DisabledAccount({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
      children: [
        ScreenUtil().setVerticalSpacing(32.h),
        Center(
          child: Text(
            "Delete account",
            style: Styles.boldTitle.copyWith(
              color: context.color.black,
              fontSize: 24.sp,
              fontFamily: Styles.gilroyMedium,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(12.h),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "The account can be restored in 60 days, after which it will be completely deleted.",
              style: Styles.headline7.copyWith(color: context.color.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ScreenUtil().setVerticalSpacing(40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: LongButton(
            buttonName: "Delete",
            onPress: onPress,
            gradient: context.color.gradientRed,
            gradientOpacity: context.color.gradientRedOpacity,
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TransparentLongButton(
            buttonName: context.l10n.profile_logout_cancel,
            onPress: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h)
      ],
    );
  }
}
