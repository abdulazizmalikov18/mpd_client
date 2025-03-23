import 'package:flutter/cupertino.dart';
import 'package:mpd_client/l10n/app_localizations.dart';
export 'package:mpd_client/l10n/app_localizations.dart';
import 'package:mpd_client/provider/language.dart';

extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
