import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ChangeNumberDialog extends StatelessWidget {
  const ChangeNumberDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AlertDialog(
        backgroundColor: colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            24.verticalSpace,
            Container(
              height: 50.w,
              width: 50.w,
              decoration: ShapeDecoration(
                  color: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  )),
              child: Center(
                child: icons.clear.svg(
                  color: colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "this_number_is_already_linked".tr(args: ["+998 12 345 67 89"]),
                style: fonts.headline1.copyWith(fontSize: 18.sp),
              ),
            ),
            const Divider(),
            TextButton(
              child: Text(
                "ok".tr(),
                style: fonts.subtitle2
                    .copyWith(color: colors.confirmed, fontSize: 18.sp),
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            )
          ],
        ),
      );
    });
  }
}
