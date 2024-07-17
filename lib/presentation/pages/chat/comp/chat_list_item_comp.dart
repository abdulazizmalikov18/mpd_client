import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChatListItemComp extends StatelessWidget {
  const ChatListItemComp({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          leading: CachedImageComponent(
              borderRadius: 50.r, height: 45.w, width: 45.w, imageUrl: ""),
          title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Нодир Султанов',
              style: fonts.subtitle2.copyWith(fontSize: 14.sp),
            ),
            4.horizontalSpace,
            Container(
              width: 14.w,
              height: 14.w,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                '3',
                textAlign: TextAlign.center,
                style: fonts.subtitle1
                    .copyWith(color: colors.white, fontSize: 10.sp),
              ),
            )
          ]),
          subtitle: Opacity(
            opacity: 0.50,
            child: Text(
              'hello_where_and_when_can'.tr(),
              style: fonts.subtitle1.copyWith(fontSize: 10.sp),
            ),
          ),
          trailing: CachedImageComponent(
              borderRadius: 5.r, height: 40.w, width: 40.w, imageUrl: ""),
        ),
      );
    });
  }
}
