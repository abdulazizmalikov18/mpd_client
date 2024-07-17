import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class MonthKmComp extends StatelessWidget {
  const MonthKmComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        color: colors.colorF5F5F5,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '6 месяцев, до 10 000 км',
              textAlign: TextAlign.center,
              style: fonts.headline1
                  .copyWith(color: colors.primary, fontSize: 18.sp),
            ),
            16.verticalSpace,
            Text(
              'При подписке на Orient гарантия распространяется на ремонт как новых, так и подержанных автомобилей.',
              textAlign: TextAlign.center,
              style: fonts.subtitle1.copyWith(fontSize: 15.sp),
            ),
            8.verticalSpace,
            Divider(color: colors.customGreyC3),
            Text(
              'Гарантия включает в себя ремонт основных компонентов, таких как двигатель и трансмиссия, а также навигационной системы',
              textAlign: TextAlign.center,
              style: fonts.subtitle1.copyWith(fontSize: 15.sp),
            ),
            24.verticalSpace,
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(isLeft: true),
                12.horizontalSpace,
                _buildCard(isLeft: false),
              ],
            ),
            24.verticalSpace,
          ],
        ),
      );
    });
  }

  Widget _buildCard({required bool isLeft}) {
    return Expanded(
      child: ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
        return Container(
          height: 140.h,
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: colors.customGreyC3),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: isLeft
              ? Column(
                  children: [
                    Text(
                      "Начало гарантии",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: fonts.subtitle2
                          .copyWith(fontSize: 14.sp, color: colors.primary),
                    ),
                    10.verticalSpace,
                    Text(
                      "Пробег при покупке",
                      style: fonts.subtitle1.copyWith(
                          fontSize: 12.sp, color: colors.text.withOpacity(0.5)),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Гарантия истекла",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: fonts.subtitle2
                          .copyWith(fontSize: 14.sp, color: colors.primary),
                    ),
                    10.verticalSpace,
                    Text(
                      '6 месяцев',
                      style: fonts.subtitle1,
                    ),
                    4.verticalSpace,
                    Text(
                      "или",
                      style: fonts.subtitle1.copyWith(
                          fontSize: 12.sp, color: colors.text.withOpacity(0.5)),
                    ),
                    4.verticalSpace,
                    Text(
                      '10 000 км',
                      style: fonts.subtitle1,
                    ),
                  ],
                ),
        );
      }),
    );
  }
}
