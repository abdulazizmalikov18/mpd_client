import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool isShowNotification;
  final Widget? action;
  final bool back;

  const WAppBar({
    super.key,
    required this.title,
    this.isShowNotification = true,
    this.action,
    this.back = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,

      titleSpacing: back ? 0 : null,
      leading: back ?  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: AppIcons.back.svg(width: 24, height: 24),
          ),
        ],
      ) : null,
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
