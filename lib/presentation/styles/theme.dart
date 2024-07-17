import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/presentation/styles/style.dart';

import './custom_theme_mode.dart';
import './custom_theme_mode_ext.dart';
import '../../infrastructure/services/local_database/db_service.dart';

part 'color_set.dart';
part 'font_set.dart';
part 'icon_set.dart';
part 'theme_preference.dart';

class GlobalController with ChangeNotifier {
  final _ThemePreference _dbService;
  final IconSet _iconSet;
  FontSet _fontSet;
  CustomColorSet _colorSet;
  CustomThemeMode _mode;

  CustomColorSet get colors => _colorSet;

  CustomThemeMode get mode => _mode;

  bool get isDark => _mode.isDark;

  IconSet get icons => _iconSet;

  FontSet get fonts => _fontSet;

  GlobalController._(this._colorSet, this._dbService, this._mode, this._iconSet,
      this._fontSet);

  static GlobalController create(DBService dbService) {
    final themePreference = _ThemePreference.create(dbService);
    final mode = themePreference.getMode();
    final colorSet = CustomColorSet.createOrUpdate(mode);
    final iconSet = IconSet.create;
    final fontSet = FontSet.createOrUpdate(colorSet);

    return GlobalController._(
      colorSet,
      themePreference,
      mode,
      iconSet,
      fontSet,
    );
  }

  Future<void> setLight() async {
    await _update(CustomThemeMode.light);
  }

  Future<void> setDark() async {
    await _update(CustomThemeMode.dark);
  }

  Future<void> clean() async {
    await _dbService.clean();
  }

  Future<void> toggle() async {
    if (_mode.isLight) {
      await setDark();
    } else {
      await setLight();
    }
  }

  Future<void> _update(CustomThemeMode mode) async {
    _colorSet = CustomColorSet.createOrUpdate(mode);
    _fontSet = FontSet.createOrUpdate(_colorSet);
    _mode = mode;
    notifyListeners();
    await _dbService.setMode(mode);
  }
}

class BottomNavBarController with ChangeNotifier {
  bool hiddenNavBar = false;

  BottomNavBarController._();

  static BottomNavBarController create() {
    return BottomNavBarController._();
  }

  void changeNavBar(bool enabled) {
    if (enabled != hiddenNavBar) {
      hiddenNavBar = enabled;
      notifyListeners();
    }
  }
}
