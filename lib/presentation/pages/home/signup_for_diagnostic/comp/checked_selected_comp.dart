import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CheckedSelectedComp extends StatelessWidget {
  const CheckedSelectedComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(icons.diagnostic),
        )),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'cars_checked_and_carefully_selected'.tr(),
              textAlign: TextAlign.center,
              style: Style.medium16(color: colors.white, size: 18.sp),
            ),
            16.verticalSpace,
            Opacity(
              opacity: 0.8,
              child: Divider(
                color: colors.dividerColor,
                thickness: 1.w,
              ),
            ),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: Text(
                  'presence_absence_of_accidents'.tr(),
                  textAlign: TextAlign.center,
                  style: Style.medium14(color: colors.white),
                )),
                12.horizontalSpace,
                Expanded(
                    child: Text(
                  'responsible_for_diagnostics'.tr(),
                  textAlign: TextAlign.center,
                  style: Style.medium14(color: colors.white),
                )),
              ],
            ),
          ],
        ),
      );
    });
  }
}
