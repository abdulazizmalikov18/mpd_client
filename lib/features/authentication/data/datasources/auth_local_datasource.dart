import 'package:mpd_client/features/authentication/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  static SharedPreferences? _prefs;

  AuthLocalDataSource._();

  static final _instance = AuthLocalDataSource._();

  factory AuthLocalDataSource() => _instance;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static TokenModel? get loadAccessToken {
    final access = _prefs!.getString('access');
    final refresh = _prefs!.getString('refresh');
    if (access != null || refresh != null) {
      return TokenModel(access: access, refresh: refresh);
    }
    return null;
  }

  void setToken(TokenModel token) {
    _prefs!.setString('access', token.access!);
    _prefs!.setString('refresh', token.refresh!);
  }

  Future clearToken() async {
    final isRemovedAccess = await _prefs!.remove('access');
    final isRemovedRefresh = await _prefs!.remove('refresh');
    return isRemovedAccess && isRemovedRefresh;
  }
}
