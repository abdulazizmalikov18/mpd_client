import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class AdsEmptyComp extends StatelessWidget {
  const AdsEmptyComp({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0.w),
              child: Image.asset(icons.adsCar),
            ),
            24.verticalSpace,
            Opacity(
              opacity: 0.5,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: fonts.headline1,
              ),
            ),
            24.verticalSpace,
            // MainButtonComponent(
            //
            //   margin: EdgeInsets.symmetric(horizontal: 16.w),
            //   text: "add_a_car".tr(),
            //   onPressed: onTap,
            //   childAfter: SvgPicture.asset(icons.adsCarWhite),
            //   backgroundColor: colors.primary,
            // )
          ]);
    });
  }
}
