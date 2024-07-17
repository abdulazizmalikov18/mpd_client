import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DotTitleComp extends StatelessWidget {
  const DotTitleComp(
      {super.key, required this.title, this.hasDivider = true, this.maxLine});

  final String title;
  final int? maxLine;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            4.verticalSpace,
            Row(children: [
              4.horizontalSpace,
              Container(
                height: 4.w,
                width: 4.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: colors.text.withOpacity(0.5)),
              ),
              8.horizontalSpace,
              Flexible(
                child: Text(
                  title,
                  style: Style.medium14(color: colors.text.withOpacity(0.5)),
                  maxLines: maxLine,
                ),
              ),
            ]),
            hasDivider
                ? Column(
                    children: [
                      4.verticalSpace,
                      Divider(color: colors.customGreyC3),
                      4.verticalSpace,
                    ],
                  )
                : 4.verticalSpace,
          ],
        ),
      );
    });
  }
}
