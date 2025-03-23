import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';

abstract class Decorations {
  static OutlineInputBorder focusedBorder(BuildContext context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide:  BorderSide(color: context.color.grey),
  );

  static OutlineInputBorder enabledBorder(BuildContext context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide:  BorderSide(color: context.color.border),
  );

  static OutlineInputBorder errorBorder (BuildContext context)=> OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide:  BorderSide(color: context.color.red),
  );
}
