import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class AuthAppBarComponent extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String iconPath;
  final String logoPath;
  final String profilePicPath;
  final VoidCallback? onButtonPressed;
  final Color? iconColor;
  final bool? isCanPop;
  final Color? color;
  final bool? isBorder;

  const AuthAppBarComponent({
    super.key,
    this.title = '',
    this.iconPath = '',
    this.onButtonPressed,
    this.iconColor,
    this.color,
    this.isBorder,
    this.isCanPop,
    this.profilePicPath = '',
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, controller) {
        return Container(
          height: kToolbarHeight * 3,
          decoration: BoxDecoration(
            color: color ?? colors.transparent,
            border: Border(
              bottom: BorderSide(
                  color: isBorder ?? false
                      ? colors.borderColor
                      : colors.transparent),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.w,
                top: MediaQuery.of(context).padding.top + 20.h,
                right: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // autoLeading ?? false
                SizedBox(
                    width: 30.w,
                    child: isCanPop ?? false
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: icons.back.svg(
                              color: colors.text,
                              height: 24,
                            ),
                          )
                        : null),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: 0.h,
                    ),
                    SvgPicture.asset(
                      logoPath,
                      colorFilter: iconColor != null
                          ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                          : null,
                      height: 58.h,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onButtonPressed,
                      child: iconPath.isNotEmpty
                          ? SvgPicture.asset(
                              iconPath,
                              colorFilter: ColorFilter.mode(
                                  iconColor ?? colors.icon, BlendMode.srcIn),
                            )
                          : SizedBox(
                              width: 30.w,
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
