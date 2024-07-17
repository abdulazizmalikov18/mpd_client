import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DiagnosticButtonComp extends StatelessWidget {
  const DiagnosticButtonComp(
      {super.key,
      this.backColor = Colors.transparent,
      required this.onDiagnosticTap});

  final Color backColor;
  final VoidCallback onDiagnosticTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: backColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            24.verticalSpace,
            CustomButton(
              onPressed: onDiagnosticTap,
              title: "sign_up_for_diagnostics".tr(),
              backgroundColor: colors.primary,
              verticalPadding: 13.h,
            ),
            24.verticalSpace,
            CustomButton(
              onPressed: () {},
              title: "diagnosed_vehicles".tr(),
              titleColor: colors.text,
              backgroundColor: colors.transparent,
              verticalPadding: 13.h,
            ),
            24.verticalSpace,
          ]),
        ),
      );
    });
  }
}
