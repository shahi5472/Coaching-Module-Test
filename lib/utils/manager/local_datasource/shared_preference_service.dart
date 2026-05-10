import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPreferenceService {
  void setTheme({required ThemeMode val});

  ThemeMode getTheme();

  Future<bool> setUserInformation(String val);

  Future<String> getUserInformation();

  Future<void> setAccessToken(String token);

  Future<void> setRefreshToken(String token);

  Future<String> getRefreshToken();

  Future<String> getAccessToken();

  Future<void> clear();
}

class SharedPreferenceServiceImpl implements ISharedPreferenceService {
  final _userInformation = '__coaching_module_information__';
  final _themeMode = '__coaching_module_them_mode__';
  final _accessToken = '__coaching_module_access_token__';
  final _refreshToken = '__coaching_module_refresh_token__';

  final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage;

  SharedPreferenceServiceImpl(this._preferences, this._secureStorage);

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
    await _preferences.clear();
  }

  @override
  ThemeMode getTheme() {
    final result = _preferences.getString(_themeMode);
    if (result == null) {
      return ThemeMode.light;
    }
    if (result.toLowerCase() == ThemeMode.light.name.toLowerCase()) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  @override
  void setTheme({required ThemeMode val}) {
    _preferences.setString(_themeMode, val.name);
  }

  @override
  Future<String> getUserInformation() async {
    final userDataString = await _secureStorage.read(key: _userInformation);
    return userDataString ?? '';
  }

  @override
  Future<bool> setUserInformation(String val) async {
    await _secureStorage.write(key: _userInformation, value: val);
    return true;
  }

  @override
  Future<String> getAccessToken() async {
    final token = await _secureStorage.read(key: _accessToken);
    return token ?? '';
  }

  @override
  Future<void> setAccessToken(String token) async {
    await _secureStorage.write(key: _accessToken, value: token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshToken, value: token);
  }

  @override
  Future<String> getRefreshToken() async {
    final token = await _secureStorage.read(key: _refreshToken);
    return token ?? '';
  }
}
