import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomCheckBoxComponent extends StatelessWidget {
  const CustomCheckBoxComponent({
    super.key,
    required this.isCheck,
    required this.onChanged,
    this.horizontalMargin = 12,
  });

  final bool isCheck;
  final Function() onChanged;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return GestureDetector(
        onTap: onChanged,
        child: Container(
          height: 20.w,
          width: 20.w,
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
          decoration: ShapeDecoration(
              color: colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
                side: BorderSide(
                    width: 1.w,
                    color: isCheck ? colors.primary : colors.customGreyC3),
              )),
          child: isCheck
              ? Container(
                  height: 10.w,
                  width: 10.w,
                  margin: const EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                      color: colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      )))
              : null,
        ),
      );
    });
  }
}

//
class CustomCheckBoxRectangleComponent extends StatelessWidget {
  const CustomCheckBoxRectangleComponent({
    super.key,
    required this.isCheck,
    required this.onChanged,
    this.horizontalMargin = 12,
  });

  final bool isCheck;
  final Function() onChanged;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return GestureDetector(
        onTap: onChanged,
        child: Container(
          height: 25.w,
          width: 25.w,
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: BorderSide(
                  width: 1.w,
                  color: isCheck ? colors.primary : colors.customGreyC3),
            ),
          ),
          padding: const EdgeInsets.all(4),
          child: isCheck ? icons.check.svg(color: colors.primary) : null,
        ),
      );
    });
  }
}
