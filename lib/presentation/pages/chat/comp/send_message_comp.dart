import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SendMessageComp extends StatelessWidget {
  const SendMessageComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Padding(
        padding: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: AnimationButtonEffect(
            onTap: () {},
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.white,
              ),
              child: icons.plus.svg(color: colors.primary),
            ),
          ),
          title: TextFormField(
            decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                fillColor: colors.white,
                hintText: "enter_your_message".tr(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide:
                      BorderSide(color: colors.customGreyC3, width: 1.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide:
                      BorderSide(color: colors.customGreyC3, width: 1.w),
                )),
          ),
          trailing: AnimationButtonEffect(
            onTap: () {},
            child: SvgPicture.asset(icons.sendMessage),
          ),
        ),
      );
    });
  }
}
