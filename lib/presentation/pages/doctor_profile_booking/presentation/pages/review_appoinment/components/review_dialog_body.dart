import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';

class ReviewDialogBody extends StatelessWidget {
  final String icon, title, subtitle;
  final String firstButtonName, secondButtonName;
  final VoidCallback firstButtonPressed, secondButtonPressed;
  final bool isError;
  const ReviewDialogBody({
    super.key,
    this.isError = false,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.firstButtonPressed,
    required this.secondButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        Container(
          height: 156.h,
          width: 156.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !isError
                ? orangeLight.withValues(alpha: 0.1)
                : gradientRedOpacity.withValues(alpha: 0.1),
          ),
          child: SvgPicture.asset(icon),
        ),
        const SizedBox(height: 26),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Styles.boldTitle.copyWith(
                color: !isError ? grey : gradientRedOpacity,
                fontSize: 24.sp,
                fontFamily: Styles.gilroyMedium),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.descSubtitle.copyWith(color: grey, height: null),
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: LongButton(
              buttonName: firstButtonName, onPress: firstButtonPressed),
        ),
        const SizedBox(height: 24),
        TextButton(
          style: TextButton.styleFrom(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r))),
          onPressed: secondButtonPressed,
          child: Text(
            secondButtonName,
            style: Styles.descSubtitle.copyWith(
              color: mainBlue,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
