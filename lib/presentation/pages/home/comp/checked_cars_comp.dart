import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CheckedCarsComp extends StatelessWidget {
  const CheckedCarsComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: const EdgeInsets.all(16),
        color: colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'having_trouble_buying_used_car'.tr(),
              textAlign: TextAlign.center,
              style: Style.medium20(size: 18.sp),
            ),
            12.verticalSpace,
            Opacity(
              opacity: 0.5,
              child: Text(
                'trust_center_with_experts'.tr(),
                textAlign: TextAlign.center,
                style: Style.medium20(size: 18.sp),
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                _customCard(colors, icons.carRepair, "car_performance".tr()),
                10.horizontalSpace,
                _customCard(colors, icons.carRepair2,
                    "complicated_selection_process".tr()),
              ],
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () {},
              title: "verified_cars".tr(),
              backgroundColor: colors.white,
              titleColor: colors.primary,
              verticalPadding: 10.h,
            )
          ],
        ),
      );
    });
  }

  Widget _customCard(CustomColorSet colors, iconName, title) {
    return Expanded(
      child: Column(children: [
        Container(
          width: 90.w,
          height: 90.w,
          decoration: BoxDecoration(
            color: colors.subText,
            borderRadius: BorderRadius.circular(50.r),
            image: DecorationImage(
              image: AssetImage(iconName),
              fit: BoxFit.cover,
            ),
          ),
        ),
        8.verticalSpace,
        Opacity(
          opacity: 0.5.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Style.medium14(),
          ),
        )
      ]),
    );
  }
}
