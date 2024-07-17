import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class TopUpFinishedPage extends StatelessWidget {
  const TopUpFinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50.w,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: colors.confirmed,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: icons.check.svg(
                      color: colors.white,
                      height: 40,
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "your_balance_has_been_replenished_by".tr(),
                    textAlign: TextAlign.center,
                    style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                  ),
                  Text(
                    "15 000 сум",
                    textAlign: TextAlign.center,
                    style: fonts.headline1
                        .copyWith(color: colors.text.withOpacity(0.5)),
                  ),
                  36.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, AppRoutes.main(index: 4));
                    },
                    backgroundColor: colors.primary,
                    title: "go_to_my_profile".tr(),
                    verticalPadding: 13.h,
                  ),
                ]),
          ),
        ),
      );
    });
  }
}
