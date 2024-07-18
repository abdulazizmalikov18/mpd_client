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
  final String subTitle;
  final void Function() onPressed;
  final bool isRed;

  const WProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.isRed = false,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: WButton(
        borderRadius: 12,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: wgradient,
                  border: Border.all(color: white.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: white.withOpacity(0.1),
                    width: 2,
                    strokeAlign: -2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: icon.svg(
                    color: white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.displayLarge,
                    ),
                    Text(
                      subTitle,
                      style: AppTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              // AppIcons.arrowRightMenu.svg(),
            ],
          ),
        ),
      ),
    );
  }
}
