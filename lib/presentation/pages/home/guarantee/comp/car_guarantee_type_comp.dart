import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CarGuaranteeTypeComp extends StatelessWidget {
  const CarGuaranteeTypeComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        padding: const EdgeInsets.all(16),
        color: colors.colorF5F5F5,
        child: Column(
          children: [
            24.verticalSpace,
            Text(
              'На какой тип автомобиля распространяется гарантия Orient?',
              textAlign: TextAlign.center,
              style: fonts.headline1.copyWith(fontSize: 18.sp),
            ),
            24.verticalSpace,
            _buildRow(
                title: "1.",
                subtitle:
                    "Автомобили дилеров, отобранные по собственным стандартам Orient или входящие в состав дочерних комплексов.",
                colors: colors,
                fonts: fonts),
            _buildRow(
                title: "2.",
                subtitle:
                    "Транспортные средства, прошедшие проверку производительности в Центре производительности Encar (напрямую управляемые или аффилированные)",
                colors: colors,
                fonts: fonts),
            _buildRow(
                title: "3.",
                subtitle:
                    "Транспортные средства, все проверенные детали которых оценены как «хорошие» или «нормальные».",
                colors: colors,
                fonts: fonts),
            _buildRow(
                title: "4.",
                subtitle:
                    "Отечественные транспортные средства моложе 10 лет на дату первой регистрации.",
                colors: colors,
                fonts: fonts),
            _buildRow(
                title: "5.",
                subtitle: "Автомобили с пробегом менее 150 000 км.",
                colors: colors,
                fonts: fonts,
                hasDivider: false),
            24.verticalSpace,
          ],
        ),
      );
    });
  }

  Widget _buildRow({
    required String title,
    required String subtitle,
    required CustomColorSet colors,
    required FontSet fonts,
    bool hasDivider = true,
  }) {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: fonts.subtitle1,
          ),
          4.horizontalSpace,
          Flexible(
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              style: fonts.subtitle1,
            ),
          )
        ]),
        if (hasDivider) Divider(color: colors.customGreyC3)
      ],
    );
  }
}
