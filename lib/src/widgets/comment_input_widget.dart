import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/src/decorations/input_border.dart';
import 'package:mpd_client/src/themes/styles.dart';

class CommentInputWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final String hintText;
  final TextEditingController? controller;
  const CommentInputWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: Styles.headline7.copyWith(fontSize: 14.sp),
        onChanged: onChanged,
        maxLines: 7,
        textAlignVertical: TextAlignVertical.top,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintStyle: Styles.headline7.copyWith(
            fontSize: 14.sp,
            color: context.color.grey,
          ),
          hintText: hintText,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          enabledBorder: Decorations.enabledBorder(context),
          focusedBorder: Decorations.focusedBorder(context),
          border: Decorations.enabledBorder(context),
          errorBorder: Decorations.errorBorder(context),
        ),
      ),
    );
  }
}
