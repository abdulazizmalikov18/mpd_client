import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/premium_diagnostic/comp/diagnostic_dialog_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/checked_selected_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/diagnostic_buttons_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/faq_comp.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/info_diagnostic_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SignupForDiagnosticPage extends StatefulWidget {
  const SignupForDiagnosticPage({super.key});

  @override
  State<SignupForDiagnosticPage> createState() =>
      _SignupForDiagnosticPageState();
}

class _SignupForDiagnosticPageState extends State<SignupForDiagnosticPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Scaffold(
          backgroundColor: colors.backgroundScaffold,
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70.h,
                      child: AppBarComponent(
                        title: "sign_up_for_diagnostics".tr(),
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
                    const CheckedSelectedComp(),
                    InfoDiagnosticComp(
                      backgroundColor: colors.white,
                      title:
                          "Диагностические автомобили можно смело покупать даже при замене внешних панелей.",
                      redText: "01",
                      subTitle:
                          "Автомобиль с заменой наружной панели точно диагностирует раму, окружающую область .",
                    ),
                    InfoDiagnosticComp(
                      backgroundColor: colors.transparent,
                      title:
                          "Технология искусственного интеллекта точно диагностирует варианты и классы, которые определяют цены на автомобили .",
                      redText: "02",
                      subTitle:
                          "В зависимости от года/месяца автомобиля, одна и та же модель имеет разные оценки, ицена отличается в зависимости от категории, поэтому необходимо точное подтверждение.",
                    ),
                    const FAQComp(),
                    DiagnosticButtonComp(onDiagnosticTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const DiagnosticDialogComp(isPremium: false);
                          });
                    }),
                    const PolicyComp(),
                    36.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
