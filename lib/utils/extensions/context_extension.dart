import 'package:flutter/material.dart';
import 'package:mpd_client/utils/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  Locale get locale => Localizations.localeOf(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  AppLocalizations get l10n => AppLocalizations.of(this);
}
