import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ShareButtonComp extends StatelessWidget {
  const ShareButtonComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AnimationButtonEffect(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(icons.share),
                    8.horizontalSpace,
                    Text(
                      'share'.tr(),
                      textAlign: TextAlign.center,
                      style: Style.medium14(),
                    ),
                  ]),
            ),
          ));
    });
  }
}
