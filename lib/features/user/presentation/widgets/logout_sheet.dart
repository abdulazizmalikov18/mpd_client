import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/transparent_long_button.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../src/themes/styles.dart';
import '../../../../../../src/widgets/bottom_sheet_widget.dart';

class LogOutSheet extends StatelessWidget {
  final VoidCallback onPress;
  const LogOutSheet({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isDeletedToken) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);
        }
      },
      child: BottomSheetWidget(
        children: [
          ScreenUtil().setVerticalSpacing(32.h),
          Center(
            child: Text(
              context.l10n.profile_logout,
              style: Styles.boldTitle.copyWith(
                color: context.color.black,
                fontSize: 24.sp,
                fontFamily: Styles.gilroyMedium,
              ),
            ),
          ),
          ScreenUtil().setVerticalSpacing(12.h),
          Center(
            child: Text(
              context.l10n.profile_logout_page,
              style: Styles.headline7.copyWith(color: context.color.grey),
            ),
          ),
          ScreenUtil().setVerticalSpacing(40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: LongButton(
              buttonName: context.l10n.profile_logout,
              onPress: onPress,
              color: context.color.red,
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
          ScreenUtil().setVerticalSpacing(32.h),
        ],
      ),
    );
  }
}
