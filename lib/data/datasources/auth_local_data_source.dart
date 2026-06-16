import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> getRememberMe();

  Future<String?> getRememberedEmail();

  Future<bool> getSessionOnlyLogin();

  Future<void> setSessionOnlyLogin(bool value);

  Future<bool> hasSeenOnboarding();

  Future<void> markOnboardingSeen();

  Future<void> saveRememberedEmail(String email);

  Future<void> clearRememberedEmail();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._preferences);

  static const String _rememberMeKey = 'remember_me';
  static const String _rememberedEmailKey = 'remembered_email';
  static const String _sessionOnlyLoginKey = 'session_only_login';
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

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
  Future<bool> getSessionOnlyLogin() async {
    return _preferences.getBool(_sessionOnlyLoginKey) ?? false;
  }

  @override
  Future<void> setSessionOnlyLogin(bool value) async {
    await _preferences.setBool(_sessionOnlyLoginKey, value);
  }

  @override
  Future<bool> hasSeenOnboarding() async {
    return _preferences.getBool(_hasSeenOnboardingKey) ?? false;
  }

  @override
  Future<void> markOnboardingSeen() async {
    await _preferences.setBool(_hasSeenOnboardingKey, true);
  }

  @override
  Future<void> saveRememberedEmail(String email) async {
    await _preferences.setBool(_rememberMeKey, true);
    await _preferences.setBool(_sessionOnlyLoginKey, false);
    await _preferences.setString(_rememberedEmailKey, email);
  }

  @override
  Future<void> clearRememberedEmail() async {
    await _preferences.setBool(_rememberMeKey, false);
    await _preferences.remove(_rememberedEmailKey);
  }
}
