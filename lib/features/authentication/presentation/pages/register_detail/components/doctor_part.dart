import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class DoctorPart extends StatelessWidget {
  const DoctorPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ScreenUtil().setVerticalSpacing(24.h),
        Text(
          'Do you want to\n work as doctor?',
          textAlign: TextAlign.center,
          style: Styles.boldTitle,
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: LongButton(
              buttonName: 'I am doctor',
              onPress: () {
                AuthInheritedNotifier.of(context).notifier!.currentIndex = 3;
              }),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('I will only buy offers?',
                  style: Styles.headline6.copyWith(color: context.color.black, fontWeight: FontWeight.w500)),
              ScreenUtil().setHorizontalSpacing(5.w),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainPage, (route) => false);
                },
                child: Text(
                  'Skip',
                  style: Styles.headline6.copyWith(color: context.color.mainBlue, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(40.h),
      ],
    );
  }
}
