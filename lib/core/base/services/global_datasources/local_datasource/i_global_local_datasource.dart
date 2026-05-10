import 'package:flutter/material.dart';

abstract class IGlobalLocalDataSource {
  Future<void> setTheme({required ThemeMode theme});

  Future<ThemeMode> getTheme();

  Future<bool> userLoggedIn();

  Future<bool> clearUserAccessTokens();

  Future<String> getAccessToken();

  Future<void> saveAccessToken(String token);
}
