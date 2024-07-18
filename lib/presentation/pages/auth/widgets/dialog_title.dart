import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_scale_animation.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: white,
              ),
            ),
            WScaleAnimation(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close, color: greyText),
            ),
          ],
        ),
      ],
    );
  }
}
