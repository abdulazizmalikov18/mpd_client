import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class InfoPreDiagnosticComp extends StatelessWidget {
  const InfoPreDiagnosticComp({
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
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: backgroundColor,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                redText.isEmpty
                    ? const SizedBox()
                    : Text(
                        redText,
                        style: Style.bold16(color: colors.primary, size: 24.sp),
                      ),
                8.verticalSpace,
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: Style.medium16(size: 18.sp),
                ),
                16.verticalSpace,
                Text(
                  subTitle,
                  textAlign: TextAlign.left,
                  style: Style.medium14(),
                ),
              ],
            ),
          ),
          Image.asset(icons.team, fit: BoxFit.contain),
        ],
      );
    });
  }
}
