import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../app/model/base/errors/failures.dart';
import '../../../../../utils/manager/extensions/custom_string_extensions.dart';
import '../../../../../utils/manager/local_datasource/shared_preference_service.dart';
import '../../../../features/auth/services/data/login_response_model.dart';
import 'i_global_local_datasource.dart';

class GlobalLocalDataSourceImpl extends IGlobalLocalDataSource {
  final ISharedPreferenceService _iSharedPreferenceService;

  GlobalLocalDataSourceImpl({
    required ISharedPreferenceService iSharedPreferenceService,
  }) : _iSharedPreferenceService = iSharedPreferenceService;

  @override
  Future<bool> userLoggedIn() async {
    final accessToken = await _iSharedPreferenceService.getAccessToken();
    return !accessToken.isNullOrEmpty;
  }

  @override
  Future<LoginResponseModel> getUserInformation() async {
    try {
      final result = await _iSharedPreferenceService.getUserInformation();
      if (result.isNotEmpty) {
        return LoginResponseModel.fromJson(jsonDecode(result));
      } else {
        return LoginResponseModel.empty();
      }
    } catch (_) {
      throw const CacheFailure("Something went wrong");
    }
  }

  @override
  Future<bool> setUserInformation(LoginResponseModel model) {
    try {
      return _iSharedPreferenceService.setUserInformation(jsonEncode(model));
    } catch (_) {
      throw const CacheFailure("Something went wrong");
    }
  }

  @override
  Future<bool> clearUserAccessTokens() async {
    await _iSharedPreferenceService.clear();
    return true;
  }

  @override
  Future<String> getAccessToken() async {
    return _iSharedPreferenceService.getAccessToken();
  }

  @override
  Future<String> getRefreshToken() async {
    return _iSharedPreferenceService.getRefreshToken();
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _iSharedPreferenceService.setAccessToken(token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _iSharedPreferenceService.setRefreshToken(token);
  }

  @override
  Future<void> setTheme({required ThemeMode theme}) async {
    _iSharedPreferenceService.setTheme(val: theme);
  }

  @override
  Future<ThemeMode> getTheme() async {
    try {
      return _iSharedPreferenceService.getTheme();
    } catch (_) {
      throw const CacheFailure("Something went wrong");
    }
  }
}
