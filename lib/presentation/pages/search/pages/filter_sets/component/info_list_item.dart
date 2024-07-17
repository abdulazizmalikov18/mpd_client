import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class InfoListItem extends StatelessWidget {
  const InfoListItem({
    super.key,
    required this.title,
    required this.fonts,
    required this.colors,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  final FontSet fonts;
  final CustomColorSet colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: fonts.subtitle1.copyWith(fontSize: 16.sp),
        ),
        10.verticalSpace,
        Text(
          subtitle,
          style: fonts.subtitle1.copyWith(
              fontSize: 13.sp, color: colors.customBlack.withOpacity(0.5)),
        ),
      ],
    );
  }
}
