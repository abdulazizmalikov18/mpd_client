import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:mpd_client/core/extension/context_ext.dart';

class Styles {
  Styles._();

  static const String gilroyLight = 'Gilroy Light';
  static const String gilroyRegular = 'Gilroy Regular';
  static const String gilroyMedium = 'Gilroy Medium';

  static TextStyle postTitle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );
  static TextStyle postSubtitle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );
  static TextStyle expTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
    height: 1.3,
  );

  static TextStyle boldTitle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 1.4,
    fontFamily: gilroyMedium,
  );

  static TextStyle boldHeadline6 = TextStyle(
    fontFamily: gilroyMedium,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );

  static TextStyle descSubtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
    height: 1.3,
  );
  static TextStyle boldTopHint = TextStyle(
    fontFamily: gilroyMedium,
    fontWeight: FontWeight.w500,
    fontSize: 15.sp,
  );

  static TextStyle headline7 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline7Bold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
  );

  static TextStyle title = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.w700,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline6 = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline5 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline8 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );

  static TextStyle semiboldTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
  );

  static TextStyle emptyboldTitle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
  );

  static TextStyle headline4 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: gilroyMedium,
    // color: context.color.black,
  );

  static TextStyle headline7Sp14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: gilroyMedium,
    // color: context.color.mainBlue,
  );
  static TextStyle bottomLabel = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: gilroyMedium,
  );
  static TextStyle cardReview = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w300,
    fontFamily: gilroyMedium,
  );
}
