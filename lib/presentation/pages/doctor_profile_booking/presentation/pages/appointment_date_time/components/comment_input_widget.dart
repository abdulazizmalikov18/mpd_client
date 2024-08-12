import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';

class CommentInputWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final String hintText;
  final TextEditingController? controller;
  const CommentInputWidget({super.key, required this.hintText, required this.onChanged, this.controller});

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
          hintStyle: Styles.headline7.copyWith(fontSize: 14.sp, color: grey),
          hintText: hintText,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: border),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: red),
          ),
        ),
      ),
    );
  }
}
