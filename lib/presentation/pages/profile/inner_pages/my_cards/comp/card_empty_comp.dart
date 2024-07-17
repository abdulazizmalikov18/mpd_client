import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CardEmptyComp extends StatefulWidget {
  const CardEmptyComp({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onTap;
  final String title;
  final String subtitle;

  @override
  State<CardEmptyComp> createState() => _CardEmptyCompState();
}

class _CardEmptyCompState extends State<CardEmptyComp> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          child: Column(
            children: [
              78.verticalSpace,
              AnimationButtonEffect(
                onTap: widget.onTap,
                child:
                    Image.asset(icons.emptyCard, height: 140.w, width: 140.w),
              ),
              24.verticalSpace,
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: fonts.subtitle2.copyWith(fontSize: 18.sp),
              ),
              10.verticalSpace,
              Opacity(
                opacity: 0.50,
                child: Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: fonts.subtitle1,
                ),
              ),
              24.verticalSpace,
              CustomButton(
                onPressed: () {
                  Navigator.pushReplacement(context, AppRoutes.main(index: 4));
                },
                backgroundColor: colors.primary,
                title: "go_to_my_profile".tr(),
                verticalPadding: 13.h,
              ),
            ],
          ),
        ),
      );
    });
  }
}
