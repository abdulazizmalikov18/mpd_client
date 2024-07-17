import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme.dart';

class GenerationListItem extends StatelessWidget {
  const GenerationListItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap,
      required this.fonts,
      required this.colors,
      required this.count});
  final String title;
  final String subtitle;
  final String count;
  final VoidCallback onTap;
  final FontSet fonts;
  final CustomColorSet colors;

  @override
  Widget build(BuildContext context) {
    return AnimationButtonEffect(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: fonts.subtitle1.copyWith(fontSize: 16.sp),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  style: fonts.subtitle1.copyWith(
                      fontSize: 14.sp,
                      color: colors.customBlack.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          15.w.horizontalSpace,
          Text(
            count,
            style: fonts.subtitle1.copyWith(
                fontSize: 14.sp, color: colors.customBlack.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
