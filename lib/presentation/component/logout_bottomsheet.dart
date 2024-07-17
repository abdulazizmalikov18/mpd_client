import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/main_button_component.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class CustomAuthBottomSheet extends StatelessWidget {
  final String title;
  final String content;
  final String titleButton;
  final VoidCallback onTap;

  const CustomAuthBottomSheet({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    required this.titleButton,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, GlobalController controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetLine(),
              SizedBox(height: 8.h),
              Text(
                content.tr(),
                style: fonts.caption.copyWith(fontSize: 15.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainButtonComponent(
                    height: 40.h,
                    width: 96.w,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'cancel'.tr(),
                    fontSize: 14.sp,
                    textColor: colors.text,
                    backgroundColor: colors.transparent,
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                    borderColor: colors.borderColor,
                  ),
                  SizedBox(width: 44.w),
                  MainButtonComponent(
                    height: 40.h,
                    width: 96.w,
                    onPressed: onTap,
                    text: titleButton.tr(),
                    textColor: colors.white,
                    fontSize: 14.sp,
                    backgroundColor: colors.redText,
                    margin: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }
}

class BottomSheetLine extends StatelessWidget {
  const BottomSheetLine({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, controller) {
        return Container(
          height: 4.h,
          width: 64.w,
          margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: colors.bodyText.withOpacity(.1),
          ),
        );
      },
    );
  }
}
