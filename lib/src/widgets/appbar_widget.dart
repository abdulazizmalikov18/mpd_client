import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_colors.dart';
import '../themes/styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: context.color.white,
      titleSpacing: 0,
      elevation: 0,
      foregroundColor: context.color.black,
      // leading: IconButton(
      //   onPressed: () => Navigator.pop(context),
      //   padding: EdgeInsets.zero,
      //   constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      //   icon: SvgPicture.asset(
      //     AppIcons.back,
      //     colorFilter:  ColorFilter.mode(context.color.black, BlendMode.srcIn),
      //     height: 20.h,
      //     width: 20.h,
      //   ),
      // ),
      title: Text(
        title,
        style: Styles.headline4.copyWith(color: context.color.black),
      ),
    );
  }
}
