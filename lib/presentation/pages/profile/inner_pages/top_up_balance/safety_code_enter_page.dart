import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/pages/auth/sing_up/comp/count_down_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SafetyCodeEnterPage extends StatelessWidget {
  const SafetyCodeEnterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        appBar: AppBarComponent(
          title: "enter_code".tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'to_your_number'
                          .tr(namedArgs: {'number': '+998 99 535 57 99'}),
                      style: fonts.headline1,
                    ),
                    // TextSpan(
                    //   text: '+998 99 535 57 68\n',
                    //   style: fonts.subtitle2,
                    // ),
                    // TextSpan(
                    //   text: '',
                    //   style: fonts.headline1,
                    // ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              24.0.verticalSpace,
              Text(
                'code_was_entered_incorrectly'.tr(),
                textAlign: TextAlign.center,
                style: fonts.headline1.copyWith(color: colors.primary),
              ),
              24.0.verticalSpace,
              CustomTextFieldWithIcon(
                readOnly: true,
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
                controller: TextEditingController(),
                icons: icons.message,
                colors: colors,
                hintText: '123456',
              ),
              24.0.verticalSpace,
              CustomButton(
                onPressed: () {
                  Navigator.push(context, AppRoutes.getTopUpFinished());
                },
                title: "pay".tr(),
                verticalPadding: 13.h,
                backgroundColor: colors.primary,
                titleColor: colors.white,
              ),
              24.0.verticalSpace,
              CountDownComp(
                seconds: 59,
                onTap: () {},
                refresh: 1,
              )
            ],
          ),
        ),
      );
    });
  }
}
