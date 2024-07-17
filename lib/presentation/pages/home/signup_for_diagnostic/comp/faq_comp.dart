import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class FAQComp extends StatelessWidget {
  final List<({String title, String childText})> titles;
  const FAQComp({super.key, this.titles = const []});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQs',
              textAlign: TextAlign.center,
              style: Style.medium20(size: 18),
            ),
            16.verticalSpace,
            ...titles.asMap().entries.map(
                  (e) => _expansionTile(
                    context: context,
                    title: e.value.title,
                    childText: e.value.childText,
                    colors: colors,
                    index: e.key + 1,
                  ),
                ),
          ],
        ),
      );
    });
  }

  Widget _expansionTile(
      {required BuildContext context,
      required String title,
      required String childText,
      required CustomColorSet colors,
      required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$index. $title", style: Style.bold16(size: 12)),
        Container(
          height: 180.h,
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: colors.colorF5F5F5,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            childText,
            style: Style.regular12(color: colors.black),
          ),
        ),
      ],
    );
  }
}

//
class FAQForPageComp extends StatelessWidget {
  const FAQForPageComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            _expansionTile(
              context: context,
              title: "01. Кому и зачем проводится Avtotitet-диагностика?",
              childText:
                  "Encar Diagnosis — это сервис, которым могут воспользоваться как частные лица, так и трейдеры (дилеры). На рынке подержанных автомобилей, где клиенты теряют доверие из-за недоверия, это услуга, используемая продавцами для регистрации надежных объектов для продажи путем прозрачного раскрытия информации покупателям через диагностику encar.",
              colors: colors,
              fonts: fonts,
            ),
            8.verticalSpace,
            _expansionTile(
              context: context,
              title: "02. Кому и зачем проводится Avtotitet-диагностика?",
              childText:
                  "Encar Diagnosis — это сервис, которым могут воспользоваться как частные лица, так и трейдеры (дилеры). На рынке подержанных автомобилей, где клиенты теряют доверие из-за недоверия, это услуга, используемая продавцами для регистрации надежных объектов для продажи путем прозрачного раскрытия информации покупателям через диагностику encar.",
              colors: colors,
              fonts: fonts,
            ),
            8.verticalSpace,
            _expansionTile(
              context: context,
              title: "03. Кому и зачем проводится Avtotitet-диагностика?",
              childText:
                  "Encar Diagnosis — это сервис, которым могут воспользоваться как частные лица, так и трейдеры (дилеры). На рынке подержанных автомобилей, где клиенты теряют доверие из-за недоверия, это услуга, используемая продавцами для регистрации надежных объектов для продажи путем прозрачного раскрытия информации покупателям через диагностику encar.",
              colors: colors,
              fonts: fonts,
            ),
            8.verticalSpace,
            _expansionTile(
              context: context,
              title: "04. Кому и зачем проводится Avtotitet-диагностика?",
              childText:
                  "Encar Diagnosis — это сервис, которым могут воспользоваться как частные лица, так и трейдеры (дилеры). На рынке подержанных автомобилей, где клиенты теряют доверие из-за недоверия, это услуга, используемая продавцами для регистрации надежных объектов для продажи путем прозрачного раскрытия информации покупателям через диагностику encar.",
              colors: colors,
              fonts: fonts,
            ),
          ],
        ),
      );
    });
  }

  Widget _expansionTile(
      {required BuildContext context,
      required String title,
      required String childText,
      required CustomColorSet colors,
      required FontSet fonts}) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, unselectedWidgetColor: colors.text),
      child: ExpansionTile(
        title: Text(title, style: Style.medium14()),
        iconColor: colors.text,
        collapsedIconColor: colors.text,
        backgroundColor: colors.customGreyE1,
        collapsedBackgroundColor: colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        childrenPadding: const EdgeInsets.all(8),
        children: [
          SizedBox(
            height: 180.h,
            child: Text(
              childText,
              style: fonts.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}
