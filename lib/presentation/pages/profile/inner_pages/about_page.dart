import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        appBar: AppBarComponent(
          title: "about_the_app".tr(),
        ),
        body: Stack(children: [
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SvgPicture.asset(icons.logo, height: 60.w),
              ),
              16.verticalSpace,
              Text(
                "Версия 14. 25. 0 от февраля 2024г.\nСборка 37780",
                style: fonts.headline1.copyWith(color: colors.customGreyC3),
                textAlign: TextAlign.center,
              )
            ],
          )),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Column(children: [
              Text("for_any_questions".tr(), style: fonts.headline1),
              AnimationButtonEffect(
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'orientmotors@gmail.com',
                  );
                  if (await canLaunchUrl(emailLaunchUri)) {
                    await launchUrl(emailLaunchUri);
                  } else {
                    throw 'Could not launch $emailLaunchUri';
                  }
                },
                child: Text("orientmotors@gmail.com",
                    style: fonts.headline1
                        .copyWith(color: const Color(0xFF007CFF))),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(icons.cc, width: 10.w, height: 10.w),
                  4.horizontalSpace,
                  Text("«ORIENTMOTORS»",
                      style:
                          fonts.headline1.copyWith(color: colors.customGreyC3)),
                ],
              ),
            ]),
          )
        ]),
      );
    });
  }
}
