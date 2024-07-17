import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/extensions.dart';

class InfoDiagnosticComp extends StatelessWidget {
  const InfoDiagnosticComp({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.redText,
    required this.subTitle,
  });

  final Color backgroundColor;
  final String title;
  final String redText;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: const EdgeInsets.all(16),
        color: backgroundColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Style.medium16(size: 18.sp),
            ).animateText(),
            16.verticalSpace,
            Image.asset(icons.diagnostic2),
            16.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  redText,
                  style: Style.bold16(color: colors.primary, size: 14.sp),
                ),
                12.horizontalSpace,
                Expanded(
                    child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: Style.medium14(),
                )),
              ],
            ),
          ],
        ),
      );
    });
  }
}
