import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NotificationItemComp extends StatelessWidget {
  final NotificationModel param;
  final bool isRead;
  const NotificationItemComp(
      {super.key,
      required this.onTap,
      required this.param,
      required this.isRead});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return AnimationButtonEffect(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: colors.colorF5F5F5,
              borderRadius: BorderRadius.circular(10.r),
              border: isRead
                  ? null
                  : Border.all(
                      color: colors.customRed,
                      width: 1.4,
                    ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageComponent(
                  fit: BoxFit.cover,
                  borderRadius: 10.r,
                  height: 150.h,
                  width: double.infinity,
                  imageUrl: param.photo ?? "",
                ),
                16.verticalSpace,
                Text(
                  param.title ?? "",
                  style: fonts.subtitle1,
                ),
                4.verticalSpace,
                Text(
                  param.description ?? "",
                  style: fonts.subtitle1.copyWith(
                      color: colors.text.withOpacity(0.5), fontSize: 12.sp),
                  maxLines: 2,
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "more_details".tr(),
                      style: fonts.subtitle1
                          .copyWith(color: colors.primary, fontSize: 12.sp),
                    ),
                    Text(
                      param.createdAt?.substring(0, 10).replaceAll("-", "/") ??
                          "",
                      style: fonts.subtitle1.copyWith(
                          color: colors.text.withOpacity(0.5), fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
