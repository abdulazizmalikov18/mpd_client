import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Color? backgroundColor;
  final Color? backIconColor;
  final bool isShowNotification;
  final Widget? action;
  final bool back;

  const WAppBar({
    super.key,
    required this.title,
    this.isShowNotification = true,
    this.action,
    this.back = false,
    this.backgroundColor,
    this.backIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: 40,
      titleSpacing: back ? 0 : null,
      
      leading: back ? BackButton(color: backIconColor ?? black) : null,
      title: title,
      actions: action == null
          ? null
          : [
              action!,
            ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
