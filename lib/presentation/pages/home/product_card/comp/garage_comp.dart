import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class GarageComp extends StatelessWidget {
  const GarageComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimationButtonEffect(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.colorF5F5F5,
                border: Border.all(width: 1.4, color: colors.customRed),
              ),
              child: Row(
                children: [
                  20.w.horizontalSpace,
                  Expanded(
                    child: Text(
                      "go_to_garage".tr(),
                      style: Style.bold16(size: 18),
                    ),
                  ),
                  4.w.horizontalSpace,
                  Image.asset(
                    icons.viewedImage,
                    height: 90.h,
                    width: 160.w,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
