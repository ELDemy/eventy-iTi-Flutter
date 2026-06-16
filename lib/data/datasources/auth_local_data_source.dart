import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> getRememberMe();

  Future<String?> getRememberedEmail();

  Future<void> saveRememberedEmail(String email);

  Future<void> clearRememberedEmail();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._preferences);

  static const String _rememberMeKey = 'remember_me';
  static const String _rememberedEmailKey = 'remembered_email';

  final SharedPreferences _preferences;

  @override
  Future<bool> getRememberMe() async {
    return _preferences.getBool(_rememberMeKey) ?? false;
  }

  @override
  Future<String?> getRememberedEmail() async {
    return _preferences.getString(_rememberedEmailKey);
  }

  @override
  Future<void> saveRememberedEmail(String email) async {
    await _preferences.setBool(_rememberMeKey, true);
    await _preferences.setString(_rememberedEmailKey, email);
  }

  @override
  Future<void> clearRememberedEmail() async {
    await _preferences.setBool(_rememberMeKey, false);
    await _preferences.remove(_rememberedEmailKey);
  }
}
