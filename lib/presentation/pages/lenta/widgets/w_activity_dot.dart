import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class WActivityDotted extends StatelessWidget {
  final int dotCount;
  final int active;
  final int type;

  const WActivityDotted({
    super.key,
    required this.dotCount,
    required this.active,
    this.type = 0,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      1 => dotCount == 1 || dotCount == 0
          ? const SizedBox()
          : DecoratedBox(
        decoration: BoxDecoration(color: black.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '${active+1}/$dotCount',
            style: AppTheme.labelSmall.copyWith(
              color: white,
            ),
          ),
        ),
      ),
      _ => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < dotCount; i++)
            AnimatedContainer(
              width: active == i ? 32 : 8,
              height: 8,
              margin: EdgeInsets.only(left: i == 0 ? 0 : 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: active == i ? white : white.withOpacity(0.2),
              ),
              duration: const Duration(milliseconds: 300),
            ),
        ],
      ),
    };
  }
}
