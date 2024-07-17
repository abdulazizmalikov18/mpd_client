import 'package:flutter/material.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class StarsComp extends StatelessWidget {
  final double starCount;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final Color? color;
  const StarsComp({
    super.key,
    required this.starCount,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.title = "",
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (BuildContext context, CustomColorSet colors, FontSet fonts,
          IconSet icons, GlobalController controller) {
        return Row(
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: Style.medium16(),
              ),
              const SizedBox(width: 12),
            ],
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: List.generate(
                5,
                (index) => Icon(
                  index < starCount
                      ? (index == starCount.toInt() &&
                              (starCount * 10) % 10 < 5)
                          ? Icons.star_half_rounded
                          : Icons.star_rounded
                      : Icons.star_border_rounded,
                  size: 18,
                  color: color ?? colors.customRed,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              starCount.toStringAsFixed(1),
              style: Style.medium14(),
            ),
          ],
        );
      },
    );
  }
}
