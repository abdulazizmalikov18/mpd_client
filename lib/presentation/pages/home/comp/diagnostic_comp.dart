import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DiagnosticComp extends StatelessWidget {
  const DiagnosticComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.verticalSpace,
          Column(
            children: [
              _customCard(
                colors: colors,
                leading: icons.service1,
                title: 'sign_up_for_avtoritet_diagnostics'.tr(),
                onPressed: () {
                  Navigator.push(context, AppRoutes.getSignupForDiagnostic());
                },
              ),
              8.verticalSpace,
              _customCard(
                colors: colors,
                leading: icons.service2,
                title: 'warranty_car_orient_motors'.tr(),
                onPressed: () {
                  Navigator.push(context, AppRoutes.getGuarantee());
                },
              ),
              8.verticalSpace,
              _customCard(
                colors: colors,
                leading: icons.service3,
                title: 'premium_diagnostics_avtoritet'.tr(),
                onPressed: () {
                  Navigator.push(context, AppRoutes.getPremiumDiagnostic());
                },
              ),
            ],
          ),
          24.verticalSpace,
        ],
      );
    });
  }

  Widget _customCard({
    required CustomColorSet colors,
    required String leading,
    required String title,
    required VoidCallback? onPressed,
  }) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: colors.colorF5F5F5),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: ListTile(
            onTap: onPressed,
            leading: Container(
                width: 40.w,
                height: 40.w,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE7E7E7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                ),
                child: Center(child: leading.svg(color: colors.customRed))),
            title: Text(
              title,
              style: Style.medium14(),
            ),
            trailing: icons.forward.svg(),
          ),
        );
      },
    );
  }
}
