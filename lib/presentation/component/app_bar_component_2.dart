import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/theme.dart';
import '../styles/theme_wrapper.dart';

class AppBarComponent2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String firstIconPath;
  final String secondIconPath;
  final VoidCallback? onFirstButtonPressed;
  final VoidCallback? onSecondButtonPressed;
  final Color? iconColor;
  final bool? autoLeading;
  final bool isAlignCenter;
  final Color? color;
  final Color? titleColor;
  final bool? isBorder;
  final bool? centerTitle;
  final Widget? bottom;

  const AppBarComponent2({
    super.key,
    this.title = '',
    this.firstIconPath = '',
    this.secondIconPath = '',
    this.isAlignCenter = true,
    this.onFirstButtonPressed,
    this.onSecondButtonPressed,
    this.iconColor,
    this.color,
    this.titleColor,
    this.isBorder,
    this.centerTitle,
    this.autoLeading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, controller) {
        return Column(
          children: [
            Container(
              height: kToolbarHeight * 2,
              decoration: BoxDecoration(
                color: color ?? colors.transparent,
                border: Border(
                  bottom: BorderSide(
                      width: 0.5,
                      color: isBorder ?? false
                          ? colors.borderColor
                          : colors.transparent),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.w,
                    top: MediaQuery.of(context).padding.top,
                    right: 16.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: autoLeading ?? false
                          ? null
                          : GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: icons.back.svg(color: colors.customBlack),
                            ),
                    ),
                    if (isAlignCenter) const Spacer(),
                    if (firstIconPath.isNotEmpty) SizedBox(width: 40.w),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 280.w,
                      ),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: centerTitle ?? true
                            ? TextAlign.center
                            : TextAlign.left,
                        style: fonts.subtitle2.copyWith(
                          fontSize: 19.sp,
                          color: titleColor ?? colors.text,
                        ),
                      ),
                    ),
                    const Spacer(),
                    (secondIconPath.isNotEmpty)
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: onFirstButtonPressed,
                                child: firstIconPath.isNotEmpty
                                    ? SvgPicture.asset(
                                        firstIconPath,
                                        colorFilter: ColorFilter.mode(
                                            iconColor ?? colors.icon,
                                            BlendMode.srcIn),
                                      )
                                    : SizedBox(
                                        width: 0.w,
                                      ),
                              ),
                              if (firstIconPath.isNotEmpty)
                                SizedBox(width: 16.w),
                              GestureDetector(
                                onTap: onSecondButtonPressed,
                                child: secondIconPath.isNotEmpty
                                    ? SvgPicture.asset(
                                        secondIconPath,
                                        colorFilter: ColorFilter.mode(
                                            iconColor ?? colors.icon,
                                            BlendMode.srcIn),
                                      )
                                    : SizedBox(
                                        width: 0.w,
                                      ),
                              ),
                            ],
                          )
                        : SizedBox(
                            width: 30.w,
                          ),
                  ],
                ),
              ),
            ),
            if (bottom != null) bottom!,
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74 + (bottom != null ? 48.h : 0));
}
