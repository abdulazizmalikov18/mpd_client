import 'package:mpd_client/core/data/repository/storage_keys.dart';
import 'package:mpd_client/core/data/repository/storage_repository.dart';

class LanguageDatabase {

  Future<String?> get loadLanguage async {
    final language = StorageRepository.getString(StorageKeys.LANGUAGE);
    return language.isNotEmpty ? language : null;
  }

  Future setLanguage(String lang) async {
    await StorageRepository.putString(StorageKeys.LANGUAGE, lang);
  }

  Future<bool> clearLanguage() async {
    StorageRepository.deleteString(StorageKeys.LANGUAGE);
    return true;
  }
}
