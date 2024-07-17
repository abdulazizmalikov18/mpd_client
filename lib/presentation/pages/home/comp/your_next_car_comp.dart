import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class YourNextCarComp extends StatelessWidget {
  const YourNextCarComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        color: colors.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'is_this_your_next_car'.tr(),
              textAlign: TextAlign.center,
              style: Style.medium16(size: 18.sp),
            ),
            12.verticalSpace,
            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w),
                child: Text(
                  'find_your_dream_car'.tr(),
                  textAlign: TextAlign.center,
                  style: Style.medium14(),
                ),
              ),
            ),
            16.verticalSpace,
            SizedBox(
              width: 120.w,
              child: CustomButton(
                onPressed: () {
                  // Navigator.push(context, AppRoutes.getProductCard());
                },
                title: "find".tr(),
                backgroundColor: colors.white,
                titleColor: colors.primary,
                verticalPadding: 10.h,
              ),
            ),
            8.verticalSpace,
            Row(
              children: [
                Expanded(child: Image.asset(icons.yellowCar)),
                24.horizontalSpace,
                Expanded(child: Image.asset(icons.redCar)),
              ],
            )
          ],
        ),
      );
    });
  }
}
