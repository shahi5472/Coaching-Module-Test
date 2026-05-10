import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../app/model/base/errors/failures.dart';
import '../../../features/auth/services/data/login_response_model.dart';
import '../../../features/auth/services/data/params/login_request_params.dart';

abstract class IGlobalRepository {
  ///##########################################[Login]##########################################

  Future<Either<Failure, LoginResponseModel>> login(LoginRequestParams params);

  ///##########################################[Login]##########################################

  Future<Either<Failure, void>> setTheme({required ThemeMode theme});

  Future<Either<Failure, ThemeMode>> getTheme();

  Future<Either<Failure, bool>> userLoggedIn();

  Future<Either<Failure, bool>> clearUserAccessTokens();

  Future<Either<Failure, String>> getAccessToken();

  Future<Either<Failure, bool>> saveAccessToken(String token);
}
