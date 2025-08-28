import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/provider/language_database.dart';

class LocalProvider extends ChangeNotifier {
  LocalProvider(this._database) {
    _getLocale();
  }

  final LanguageDatabase _database;
  Locale? _locale = AppLocalizations.supportedLocales[2];
  List<Locale> locales = [
    const Locale("uz"),
    const Locale("ru"),
    const Locale("en"),
  ];
  Locale get locale => _locale!;
  void setLocale(Locale locale) async {
    if (!locales.contains(locale)) return;
    _locale = locale;
    await _database.setLanguage(locale.languageCode);
    notifyListeners();
  }

  void _getLocale() async {
    final storedLang = await _database.loadLanguage;
    if (storedLang != null) _locale = Locale(storedLang);
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
