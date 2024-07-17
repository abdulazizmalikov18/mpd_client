import 'package:flutter/cupertino.dart';
import 'package:dwed_client/assets/colors/colors.dart';
import 'package:dwed_client/assets/constants/icons.dart';
import 'package:dwed_client/assets/themes/theme.dart';
import 'package:dwed_client/features/common/widgets/w_box_shadowed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      child: WBoxShadowed(
        borderRadius: 12,
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
              AppIcons.arrowRightMenu.svg(),
            ],
          ),
        ),
      ),
    );
  }
}
