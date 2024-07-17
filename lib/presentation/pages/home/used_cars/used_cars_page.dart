import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/info_pre_diagnostic_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/top_image_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/faq_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class UsedCarsPage extends StatelessWidget {
  const UsedCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
          backgroundColor: colors.backgroundScaffold,
          body: SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 70.h,
                          child: AppBarComponent(
                            title: "used_cars".tr(),
                            color: colors.white,
                            isBorder: true,
                          ),
                        ),
                      )
                    ],
                body: SingleChildScrollView(
                    child: Column(children: [
                  TopImageComp(
                    title: "new_way_choose_used_car".tr(),
                    subtitle: "trust_and_consult_with_the_performance".tr(),
                    image: icons.premiumD,
                  ),
                  InfoPreDiagnosticComp(
                    backgroundColor: colors.white,
                    title: "Enka с вами во всех процессах закупок.",
                    redText: "",
                    subTitle:
                        "Это ваша первая сделка с подержанным автомобилем?Если вы примете решение о покупке , выслушав объяснение эксперта по результатам технического осмотра автомобиля,менеджер центра поможет вам даже подписать договор.",
                  ),
                  const FAQComp(),
                  _trustButton(),
                  _phomeComp(colors),
                  const PolicyComp(),
                  36.verticalSpace,
                ]))),
          ));
    });
  }

  Widget _trustButton() {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return ColoredBox(
        color: colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            24.verticalSpace,
            CustomButton(
              onPressed: () {},
              title: "trust_and_go_watch".tr(),
              backgroundColor: colors.primary,
              verticalPadding: 13.h,
            ),
            24.verticalSpace,
          ]),
        ),
      );
    });
  }

  Widget _phomeComp(CustomColorSet colors) {
    return Column(children: [
      8.verticalSpace,
      ListTile(
        leading: Container(
          height: 30.w,
          width: 30.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r), color: colors.primary),
          child: Icon(Icons.phone, color: colors.white, size: 16.sp),
        ),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '+998 ',
                style: Style.medium20(size: 24.sp),
              ),
              TextSpan(
                text: '99 535 57 68',
                style: Style.bold20(size: 24.sp),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Opacity(
          opacity: 0.5,
          child: Text(
            'by_accessing_the_center'.tr(),
            style: Style.medium14(),
          ),
        ),
      ),
      8.verticalSpace,
    ]);
  }
}
