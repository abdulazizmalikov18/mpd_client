import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class CustomRowButton extends StatelessWidget {
  final void Function() ontap;
  final String title;
  const CustomRowButton({super.key, required this.ontap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, controller) {
        return GestureDetector(
          onTap: ontap,
          child: Container(
            height: 48.h,
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.tr(),
                  style: fonts.subtitle2,
                ),
                icons.forward.svg(height: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
