import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class NotificationBottomSheetComp extends StatelessWidget {
  final NotificationModel param;
  const NotificationBottomSheetComp({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageComponent(
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
                ),
                16.verticalSpace,
                Text(
                  param.createdAt?.substring(0, 10).replaceAll("-", "/") ?? "",
                  style: fonts.subtitle1.copyWith(
                      color: colors.text.withOpacity(0.5), fontSize: 12.sp),
                ),
                32.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
