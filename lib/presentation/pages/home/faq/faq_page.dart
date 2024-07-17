import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/home/signup_for_diagnostic/comp/faq_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        appBar: AppBarComponent(
          color: colors.white,
          title: 'faq'.tr(),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              FAQForPageComp(),
            ],
          ),
        ),
      );
    });
  }
}
