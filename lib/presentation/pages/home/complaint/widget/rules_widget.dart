import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/top_image_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class RulesWidget extends StatelessWidget {
  const RulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SingleChildScrollView(
          child: Column(
        children: [
          TopImageComp(
            title: "read_the_rules_of".tr(),
            subtitle: "",
            image: icons.premiumD,
          ),
          ColoredBox(
            color: colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.verticalSpace,
                  Text(
                    'suspension_of_use'.tr(),
                    style: Style.semiBold16(size: 18.sp),
                  ),
                  12.verticalSpace,
                  Text(
                    'suspension_for_year'.tr(),
                    style: Style.semiBold14(color: colors.primary),
                  ),
                  12.verticalSpace,
                  Text(
                    '1) В случае признания менеджером фальшивого регистранта, приостановка использования на 1 год вне зависимости от количества отчетов.',
                    style: Style.medium14(),
                  )
                ],
              ),
            ),
          ),
          const PolicyComp(),
        ],
      ));
    });
  }
}
