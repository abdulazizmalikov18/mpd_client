import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringExt on String {
  SvgPicture svg({
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      this,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
  String get phoneFormatter {
    if (isEmpty || length <= 11) {
      return "";
    }
    return "${substring(0, 3)} (${substring(3, 5)}) ${substring(5, 8)} ${substring(8, 10)} ${substring(10, 12)}";
  }

  String get differentCurrentDate {
    final oldDate = DateTime.tryParse(this);
    if (oldDate == null) return "--";
    final different = DateTime.now().difference(oldDate);
    if (different.inDays != 0) {
      return "${different.inDays} days ago";
    } else if (different.inHours != 0) {
      return "${different.inHours} hour ago";
    } else if (different.inMinutes != 0) {
      return "${different.inMinutes} minute ago";
    } else if (different.inSeconds != 0) {
      return "${different.inSeconds} minute ago";
    }else {
      return "---";
    }
  }
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get fromFullNameToLastName => substring(indexOf(" "));
}
