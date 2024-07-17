import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/auth/auth.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/phone_number_component.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChangeNumberPage extends StatelessWidget {
  final ProfileRes profile;

  const ChangeNumberPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 60.h),
          child: AppBarComponent(
            title: "change_number".tr(),
            color: colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              36.verticalSpace,
              Image.asset(
                icons.changePhoneRed,
                height: 140.w,
                width: 140.w,
              ),
              36.verticalSpace,
              Text(
                InternationalPhoneFormatter()
                    .internationalPhoneFormat(profile.username ?? ""),
                style: fonts.subtitle2.copyWith(
                  fontSize: 20.sp,
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "here_you_can_change_your_phone_number".tr(),
                  style: fonts.headline1.copyWith(
                    color: colors.text.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              36.verticalSpace,
              CustomButton(
                borderColor: colors.customGreyC3,
                onPressed: () {
                  Navigator.push(context, AppRoutes.getChangeWithNumber());
                },
                title: "change_number".tr(),
                backgroundColor: colors.colorF5F5F5,
                titleColor: colors.black,
                verticalPadding: 10.h,
              ),
            ],
          ),
        ),
      );
    });
  }
}
