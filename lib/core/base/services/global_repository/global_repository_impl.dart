import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../app/model/base/errors/failures.dart';
import '../../../features/auth/services/data/login_response_model.dart';
import '../../../features/auth/services/data/params/login_request_params.dart';
import '../global_datasources/local_datasource/i_global_local_datasource.dart';
import '../global_datasources/remote_datasource/i_global_remote_datasource.dart';
import 'i_global_repository.dart';

class GlobalRepositoryImpl extends IGlobalRepository {
  final IGlobalLocalDataSource _localDataSource;
  final IGlobalRemoteDatasource _remoteDatasource;

  GlobalRepositoryImpl({
    required IGlobalLocalDataSource localDataSource,
    required IGlobalRemoteDatasource remoteDatasource,
  }) : _localDataSource = localDataSource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestParams params) async {
    try {
      return right(await _remoteDatasource.login(params));
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> userLoggedIn() async {
    try {
      return right(await _localDataSource.userLoggedIn());
    } catch (e) {
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> clearUserAccessTokens() async {
    try {
      return Right(await _localDataSource.clearUserAccessTokens());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getAccessToken() async {
    try {
      return right(await _localDataSource.getAccessToken());
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveAccessToken(String token) async {
    try {
      await _localDataSource.saveAccessToken(token);
      return right(true);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setTheme({required ThemeMode theme}) async {
    try {
      return Right(await _localDataSource.setTheme(theme: theme));
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> getTheme() async {
    try {
      return Right(await _localDataSource.getTheme());
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(CacheFailure(e.toString()));
    }
  }
}
