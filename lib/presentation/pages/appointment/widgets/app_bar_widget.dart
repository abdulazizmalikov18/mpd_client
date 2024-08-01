
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';


class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final List<Widget>? actions;
  const AppBarWidget({super.key, required this.title, this.actions});

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: false,
      backgroundColor: white,
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        icon: SvgPicture.asset(
          AppIcons.back,
          colorFilter:  const ColorFilter.mode(black, BlendMode.srcIn),
          height: 20.h,
          width: 20.h,
        ),
      ),
      title: Text(title, style: Styles.headline4.copyWith(color: black)),
    );
  }
}
