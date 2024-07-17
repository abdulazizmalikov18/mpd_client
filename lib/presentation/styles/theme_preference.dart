part of 'theme.dart';

class _ThemePreference {
  final DBService _dbService;

  _ThemePreference._(this._dbService);

  static _ThemePreference create(DBService dbService) {
    return _ThemePreference._(dbService);
  }

  CustomThemeMode getMode() {
    final modeKey = _dbService.getThemeMode ?? CustomThemeMode.light.toKey;

    return CustomThemeModeX.toValue(modeKey);
  }

  Future<void> setMode(CustomThemeMode mode) async {
    await _dbService.setThemeMode(mode.toKey);
  }

  Future<void> clean() async {
    _dbService.signOut();
  }
}
