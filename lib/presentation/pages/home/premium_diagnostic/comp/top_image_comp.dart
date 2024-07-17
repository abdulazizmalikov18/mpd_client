import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class TopImageComp extends StatelessWidget {
  const TopImageComp({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        )),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            56.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: Style.semiBold16(size: 24.sp, color: colors.white),
            ),
            16.verticalSpace,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Style.medium14(color: colors.white),
            ),
            56.verticalSpace
          ],
        ),
      );
    });
  }
}
