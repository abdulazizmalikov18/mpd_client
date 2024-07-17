import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/diagnostic_dialog_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/info_pre_diagnostic_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/special_diagnostic_equipment_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/specialist_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/top_image_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/diagnostic_buttons_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/faq_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class PremiumDiagnosticPage extends StatefulWidget {
  const PremiumDiagnosticPage({super.key});

  @override
  State<PremiumDiagnosticPage> createState() => _PremiumDiagnosticPageState();
}

class _PremiumDiagnosticPageState extends State<PremiumDiagnosticPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.backgroundScaffold,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 90.h,
                      child: AppBarComponent(
                        title: "premium_diagnostics".tr(),
                        color: colors.white,
                        isBorder: true,
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TopImageComp(
                      title: 'avtoritet_premium_diagnostics'.tr(),
                      subtitle: 'as_for_private_transactions'.tr(),
                      image: icons.premiumD,
                    ),
                    InfoPreDiagnosticComp(
                      backgroundColor: colors.white,
                      title:
                          "Индивидуальная диагностика для каждого автомобиля в зависимости от производителя, модели, года выпуска и двигателя внутреннего сгорания.",
                      redText: "01",
                      subTitle:
                          "Специалист по диагностике, обладающий ноу-хау в интерпретации дифференцированной диагностики и опытом Encar, обеспечивает индивидуальную точную диагностику с помощью специального оборудования для 172 диагностических пунктов, соответствующих характеристикам каждого автомобиля.",
                    ),
                    InfoPreDiagnosticComp(
                      backgroundColor: colors.white,
                      title:
                          "Индивидуальная диагностика для каждого автомобиля в зависимости от производителя, модели, года выпуска и двигателя внутреннего сгорания.",
                      redText: "02",
                      subTitle:
                          "Специалист по диагностике, обладающий ноу-хау в интерпретации дифференцированной диагностики и опытом Encar, обеспечивает индивидуальную точную диагностику с помощью специального оборудования для 172 диагностических пунктов, соответствующих характеристикам каждого автомобиля.",
                    ),
                    InfoPreDiagnosticComp(
                      backgroundColor: colors.white,
                      title:
                          "Индивидуальная диагностика для каждого автомобиля в зависимости от производителя, модели, года выпуска и двигателя внутреннего сгорания.",
                      redText: "03",
                      subTitle:
                          "Специалист по диагностике, обладающий ноу-хау в интерпретации дифференцированной диагностики и опытом Encar, обеспечивает индивидуальную точную диагностику с помощью специального оборудования для 172 диагностических пунктов, соответствующих характеристикам каждого автомобиля.",
                    ),
                    const SpecialDiagnosticEquipmentComp(),
                    const SpecialistComp(),
                    const FAQComp(),
                    DiagnosticButtonComp(
                        onDiagnosticTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const DiagnosticDialogComp(
                                    isPremium: true);
                              });
                        },
                        backColor: colors.white),
                    const PolicyComp(),
                    36.verticalSpace,
                  ],
                ),
              )),
        ),
      );
    });
  }
}
