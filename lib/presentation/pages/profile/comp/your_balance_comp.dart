import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class YourBalanceComp extends StatelessWidget {
  const YourBalanceComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return DecoratedBox(
        decoration: ShapeDecoration(
          color: colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          title: Opacity(
            opacity: 0.50,
            child: Text(
              'your_balance'.tr(),
              style: fonts.subtitle2.copyWith(fontSize: 18.sp),
            ),
          ),
          subtitle: Text(
            '1000 сум',
            textAlign: TextAlign.left,
            style: fonts.headline1,
          ),
          trailing: AnimationButtonEffect(
            onTap: () {
              Navigator.push(context, AppRoutes.getTopUpBalance());
            },
            child: Text(
              'top_up'.tr(),
              style: fonts.headline1.copyWith(color: colors.confirmed),
            ),
          ),
        ),
      );
    });
  }
}
