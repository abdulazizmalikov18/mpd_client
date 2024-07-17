import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orient_motors/presentation/component/nav_bar/lib/persistent_tab_view.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class CustomBottomNavBarItem extends PersistentBottomNavBarItem {
  CustomBottomNavBarItem({
    required String title,
    required Color activeColorPrimary,
    required Color inactiveColorPrimary,
    required String icon,
    Key? key,
  }) : super(
          contentPadding: 0,
          icon: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 28.h,
              maxHeight: 28.h,
              maxWidth: 28.h,
              minWidth: 28.h,
            ),
            child: SvgPicture.asset(
              icon,
              height: 28.h,
              colorFilter:
                  ColorFilter.mode(activeColorPrimary, BlendMode.srcIn),
            ),
          ),
          inactiveIcon: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 28.h,
              maxHeight: 28.h,
              maxWidth: 28.h,
              minWidth: 28.h,
            ),
            child: SvgPicture.asset(
              icon,
              height: 28.h,
              colorFilter:
                  ColorFilter.mode(inactiveColorPrimary, BlendMode.srcIn),
            ),
          ),
          // title: title.tr(),
          textStyle: Style.medium14(color: Style.black, size: 10.sp),
          activeColorPrimary: Style.primary,
          inactiveColorPrimary: Style.black.withOpacity(0.5),
          inactiveColorSecondary: Style.black.withOpacity(0.5),
          activeColorSecondary: Style.black.withOpacity(0.5),
        );
}

List<PersistentBottomNavBarItem> navBarsItems(IconSet icons) {
  return [
    CustomBottomNavBarItem(
      icon: icons.home,
      title: "home",
      activeColorPrimary: Style.primary,
      inactiveColorPrimary: const Color(0xff343435),
    ),
    CustomBottomNavBarItem(
      icon: icons.like,
      title: "like",
      activeColorPrimary: Style.primary,
      inactiveColorPrimary: const Color(0xff343435),
    ),
    CustomBottomNavBarItem(
      icon: icons.createe,
      title: "create",
      activeColorPrimary: Style.primary,
      inactiveColorPrimary: const Color(0xff343435),
    ),
    CustomBottomNavBarItem(
      icon: icons.chat,
      title: "chat",
      activeColorPrimary: Style.primary,
      inactiveColorPrimary: const Color(0xff343435),
    ),
    CustomBottomNavBarItem(
      icon: icons.profile,
      title: "profile",
      activeColorPrimary: Style.primary,
      inactiveColorPrimary: const Color(0xff343435),
    ),
  ];
}
