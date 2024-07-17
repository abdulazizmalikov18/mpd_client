import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

import '../../../../../component/animation_effect.dart';

class YearOrMontPickerComponent extends StatelessWidget {
  const YearOrMontPickerComponent(
      {super.key,
      required this.selYear,
      required this.colors,
      required this.fonts,
      required this.onTap,
      this.isYear = false,
      this.startYear,
      this.endYear});

  final String selYear;
  final CustomColorSet colors;
  final FontSet fonts;
  final Function(String) onTap;
  final bool isYear;
  final int? startYear;
  final int? endYear;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: isYear
            ? ((endYear ?? DateTime.now().year) - (startYear ?? 1980) + 1)
            : 12,
        itemBuilder: (context, index) {
          String value = isYear
              ? '${(endYear ?? DateTime.now().year) - index}'
              : '${index + 1 < 10 ? "0${index + 1}" : index + 1}';
          return AnimationButtonEffect(
            onTap: () {
              onTap(value);
            },
            child: Center(
                child: Text(
              value,
              style: fonts.subtitle1.copyWith(
                  fontSize: 18.sp,
                  color: colors.customBlack
                      .withOpacity(selYear == value ? 1.0 : 0.5)),
            )),
          );
        },
        separatorBuilder: (context, index) => 20.verticalSpace,
      ),
    );
  }
}

class YearSelecInfoComponent extends StatelessWidget {
  const YearSelecInfoComponent(
      {super.key,
      required this.minYear,
      required this.minMonth,
      required this.maxYear,
      required this.maxMonth,
      required this.colors,
      required this.fonts,
      required this.showMonth});

  final String minYear;
  final String minMonth;
  final String maxYear;
  final String maxMonth;
  final bool showMonth;
  final CustomColorSet colors;
  final FontSet fonts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            minYear.isEmpty && minMonth.isEmpty
                ? Text(
                    "_ _ _ _",
                    textAlign: TextAlign.center,
                    style: fonts.subtitle2.copyWith(
                        fontSize: 22.sp, color: colors.text.withOpacity(0.5)),
                  )
                : Text(
                    minYear +
                        (minMonth.isNotEmpty && showMonth
                            ? " / $minMonth"
                            : ""),
                    textAlign: TextAlign.center,
                    style: fonts.subtitle2.copyWith(fontSize: 22.sp),
                  ),
            SizedBox(
              // height: 34.h,
              child: Text(
                "${"minimum_year".tr()}${minMonth.isNotEmpty && showMonth ? " / ${"month".tr()}" : ""}",
                textAlign: TextAlign.center,
                style: fonts.subtitle1.copyWith(
                    fontSize: 13.sp,
                    color: colors.customBlack.withOpacity(0.5)),
              ),
            ),
          ],
        )),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            maxYear.isEmpty && maxMonth.isEmpty
                ? Text(
                    "_ _ _ _",
                    textAlign: TextAlign.center,
                    style: fonts.subtitle2.copyWith(
                        fontSize: 22.sp, color: colors.text.withOpacity(0.5)),
                  )
                : Text(
                    maxYear +
                        (maxMonth.isNotEmpty && showMonth
                            ? " / $maxMonth"
                            : ""),
                    textAlign: TextAlign.center,
                    style: fonts.subtitle2.copyWith(fontSize: 22.sp),
                  ),
            SizedBox(
              // height: 34.h,
              child: Text(
                "${"maximum_year".tr()}${maxMonth.isNotEmpty && showMonth ? " / ${"month".tr()}" : ""}",
                textAlign: TextAlign.center,
                style: fonts.subtitle1.copyWith(
                    fontSize: 13.sp,
                    color: colors.customBlack.withOpacity(0.5)),
              ),
            ),
          ],
        ))
      ],
    );
  }
}

// for add car
class YearAndMonthSelecInfoComponent extends StatelessWidget {
  const YearAndMonthSelecInfoComponent({
    super.key,
    required this.minYear,
    required this.minMonth,
    required this.colors,
    required this.fonts,
  });

  final String minYear;
  final String minMonth;
  final CustomColorSet colors;
  final FontSet fonts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      minYear.isEmpty ? "----" : minYear,
                      maxLines: 1,
                      style: fonts.subtitle2.copyWith(
                          fontSize: 24.sp,
                          color: minYear.isEmpty
                              ? colors.customBlack.withOpacity(0.5)
                              : colors.customRed),
                    ),
                    Text(
                      "year".tr(),
                      style: fonts.subtitle1.copyWith(
                          fontSize: 13.sp,
                          color: colors.customBlack.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
                child: Text(
                  "/",
                  textAlign: TextAlign.center,
                  style: fonts.subtitle2
                      .copyWith(fontSize: 24.sp, color: colors.customRed),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      minMonth.isEmpty ? "--" : minMonth,
                      style: fonts.subtitle2.copyWith(
                          fontSize: 24.sp,
                          color: minMonth.isEmpty
                              ? colors.customBlack.withOpacity(0.5)
                              : colors.customRed),
                    ),
                    Text(
                      "month".tr(),
                      style: fonts.subtitle1.copyWith(
                          fontSize: 13.sp,
                          color: colors.customBlack.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
