import 'package:flutter/material.dart';

import '../../../../features/auth/services/data/login_response_model.dart';

abstract class IGlobalLocalDataSource {
  Future<void> setTheme({required ThemeMode theme});

  Future<ThemeMode> getTheme();

  Future<bool> userLoggedIn();

  Future<bool> setUserInformation(LoginResponseModel model);

  Future<LoginResponseModel> getUserInformation();

  Future<bool> clearUserAccessTokens();

  Future<String> getAccessToken();

  Future<String> getRefreshToken();

  Future<void> saveAccessToken(String token);

  Future<void> saveRefreshToken(String token);
}
