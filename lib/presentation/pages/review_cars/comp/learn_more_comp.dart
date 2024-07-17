import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class LearnMoreComp extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final double rating;

  const LearnMoreComp(
      {super.key,
      required this.title,
      required this.onTap,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Style.medium14(),
                  ),
                ),
                const SizedBox(width: 4),
                AnimationButtonEffect(
                  onTap: onTap,
                  child: icons.circularForward.svg(),
                ),
              ],
            ),
            4.verticalSpace,
            StarsComp(starCount: rating),
          ],
        );
      },
    );
  }
}
