import 'package:flutter/material.dart';
import 'package:mpd_client/app/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: false,
  );

  static ThemeData light = theme.copyWith(extensions: [AppColors.light]);
  static ThemeData dark = theme.copyWith(extensions: [AppColors.dark]);
}
