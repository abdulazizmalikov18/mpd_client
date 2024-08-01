import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class TransparentLongButton extends StatelessWidget {
  final Color? borderColor;
  final String buttonName;
  final Color? textColor;
  final VoidCallback onPress;
  final double height;
  final double width;
  final double? fontsize;
  const TransparentLongButton({super.key, required this.buttonName, this.textColor, this.borderColor, required this.onPress, this.height = 50, this.width = double.maxFinite, this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: (borderColor ?? transparentBorder)),
          color: white,
        ),
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero, enableFeedback: false, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (fontsize != null)
                SvgPicture.asset(
                  AppIcons.cartUnfilled,
                  height: 18.h,
                  width: 18.h,
                  colorFilter: ColorFilter.mode(mainBlue, BlendMode.srcIn),
                ),
              ScreenUtil().setHorizontalSpacing(6.w),
              Text(
                buttonName,
                style: Styles.boldHeadline6.copyWith(color: (textColor ?? grey), fontSize: fontsize),
              ),
            ],
          ),
        ));
  }
}
