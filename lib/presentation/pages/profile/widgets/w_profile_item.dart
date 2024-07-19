import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

class WProfileItem extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onPressed;
  final String? subTitle;
  final bool isRed;

  const WProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isRed = false,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return WButton(
      color: Colors.transparent,
      border: Border.all(
        color: Colors.transparent,
      ),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            icon.svg(
              color: isRed ? red : black,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.displayLarge.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isRed ? red : null,
                  ),
                ),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: AppTheme.displayLarge.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: mainBlue,
                    ),
                  ),
              ],
            ),
            // AppIcons.arrowRightMenu.svg(),
          ],
        ),
      ),
    );
  }
}
