import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class BuildLabel extends StatelessWidget {
  final String label;
  const BuildLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            label,
            style: Styles.boldTopHint.copyWith(fontSize: 18.sp, color: black),
          ),
        ),
      ],
    );
  }
}
