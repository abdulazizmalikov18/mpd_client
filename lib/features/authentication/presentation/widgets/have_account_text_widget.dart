import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/themes/styles.dart';

class HaveAccountTextWidget extends StatelessWidget {
  final String info, buttonText;
  final VoidCallback onPressed;

  const HaveAccountTextWidget({super.key, required this.info, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(info, style: Styles.headline6.copyWith(color: context.color.black)),
        ScreenUtil().setHorizontalSpacing(5.w),
        InkWell(
          onTap: onPressed,
          child: Text(buttonText,
              style: Styles.headline6.copyWith(color: context.color.mainBlue, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
