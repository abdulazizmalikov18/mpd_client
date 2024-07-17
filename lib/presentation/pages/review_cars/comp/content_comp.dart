import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ContentComp extends StatelessWidget {
  const ContentComp({
    super.key,
    required this.title,
    required this.subTitle,
    this.spacing = 16,
  });

  final String title;
  final String subTitle;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        color: colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: Style.medium14(),
            ),
            10.verticalSpace,
            Text(
              subTitle,
              style: Style.medium14(color: colors.black.withOpacity(0.5)),
            ),
            16.verticalSpace,
          ],
        ),
      );
    });
  }
}
