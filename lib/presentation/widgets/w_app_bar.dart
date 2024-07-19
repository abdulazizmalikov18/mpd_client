import 'package:flutter/material.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool isShowNotification;
  final Widget? action;

  const WAppBar({
    super.key,
    required this.title,
    this.isShowNotification = true,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
