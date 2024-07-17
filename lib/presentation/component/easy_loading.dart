import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class EasyLoading {
  static Future<void> show({
    String? status,
  }) async {
    await SmartDialog.dismiss();
    SmartDialog.showLoading(msg: status ?? "loading".tr());
  }

  static Future<void> dismiss() async {
    SmartDialog.dismiss();
  }

  static Future<void> showToast(String status) async {
    SmartDialog.showToast(status);
  }

  static Future<void> showError(String status, {String? description}) async {
    await SmartDialog.dismiss();
    SmartDialog.show(builder: (_) {
      return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
        return AlertDialog(
          backgroundColor: colors.white,
          surfaceTintColor: colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(15.0.r),
          )),
          contentPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimationButtonEffect(
                onTap: () {
                  SmartDialog.dismiss();
                },
                child: Container(
                  padding: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
                  color: Colors.transparent,
                  child: icons.clear.svg(
                    color: colors.text,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 1.sw - 32.w,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50.w,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: icons.clear.svg(
                      color: colors.text,
                      height: 40,
                    ),
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      status,
                      textAlign: TextAlign.center,
                      style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                    ),
                  ),
                  if (description != null)
                    Column(children: [
                      4.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: fonts.headline1
                              .copyWith(color: colors.text.withOpacity(0.5)),
                        ),
                      ),
                    ]),
                  36.verticalSpace,
                ]),
          ),
        );
      });
    });
  }

  static Future<void> showSuccess(String? status, {String? description}) async {
    await SmartDialog.dismiss();
    if (status != null) {
      SmartDialog.show(
        builder: (_) {
          return ThemeWrapper(
            builder: (context, colors, fonts, icons, controller) {
              return AlertDialog(
                backgroundColor: colors.white,
                surfaceTintColor: colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(15.0.r),
                )),
                contentPadding: EdgeInsets.zero,
                iconPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimationButtonEffect(
                      onTap: () {
                        SmartDialog.dismiss();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.transparent,
                        child: icons.check.svg(
                          color: colors.text,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                content: SizedBox(
                  width: 1.sw - 32.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: colors.confirmed,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: icons.clear.svg(
                          color: colors.text,
                          height: 40,
                        ),
                      ),
                      16.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          status,
                          textAlign: TextAlign.center,
                          style: fonts.subtitle1.copyWith(fontSize: 18.sp),
                        ),
                      ),
                      if (description != null)
                        Column(
                          children: [
                            4.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                description,
                                textAlign: TextAlign.center,
                                style: fonts.headline1.copyWith(
                                    color: colors.text.withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                      36.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
