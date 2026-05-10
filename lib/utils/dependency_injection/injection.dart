import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/network/dio_error_handler.dart';
import '../../app/network/dio_interceptor_wrapper.dart';
import '../../app/network/dio_wrapper.dart';
import '../../core/base/services/global_datasources/local_datasource/global_local_datasource_impl.dart';
import '../../core/base/services/global_datasources/local_datasource/i_global_local_datasource.dart';
import '../../core/base/services/global_datasources/remote_datasource/global_remote_datasource_impl.dart';
import '../../core/base/services/global_datasources/remote_datasource/i_global_remote_datasource.dart';
import '../../core/base/services/global_repository/global_repository_impl.dart';
import '../../core/base/services/global_repository/i_global_repository.dart';
import '../../core/base/services/global_usecases/clear_user_access_tokens.dart';
import '../../core/base/services/global_usecases/get_access_token_usecase.dart';
import '../../core/base/services/global_usecases/get_refresh_token_usecase.dart';
import '../../core/base/services/global_usecases/refresh_token_api_usecase.dart';
import '../../core/base/services/global_usecases/save_access_token.dart';
import '../../core/base/services/global_usecases/save_refresh_token.dart';
import '../../flavors.dart';
import '../../routes/navigator.dart';
import '../constansts/global.dart';
import '../manager/local_datasource/shared_preference_service.dart';
import '../manager/network/internet_change_notifier.dart';
import '../manager/network/network_info.dart';
import '../manager/network/network_info_imp.dart';
import 'custom_getit.dart';

Future<void> initDependencies() async {
  ///Local Storage
  final preferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton<SharedPreferences>(() => preferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  getIt.registerLazySingleton<ISharedPreferenceService>(() => SharedPreferenceServiceImpl(sl<SharedPreferences>(), sl<FlutterSecureStorage>()));

  ///Internet change Listener
  getIt.registerLazySingleton<InternetChangeNotifier>(() => InternetChangeNotifier());

  ///Network
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<INetworkInfo>(
    () => NetworkInfoImpl(
      connectivity: sl<Connectivity>(),
      notifier: sl<InternetChangeNotifier>(),
    ),
  );
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  getIt.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());
  getIt.registerLazySingleton<Logger>(() => Logger(filter: ShowAllLogsFilter()));
  getIt.registerLazySingleton<DioErrorHandler>(() => DioErrorHandlerImpl());

  ///Regular Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 5000),
        sendTimeout: const Duration(seconds: 5000),
        baseUrl: F.baseUrl,
      ),
    ),
  );

  getIt.registerLazySingleton<IDioWrapper>(
    () => DioWrapperImpl(
      dio: sl<Dio>(),
      dioErrorHandler: sl<DioErrorHandler>(),
      networkInfo: sl<INetworkInfo>(),
    ),
  );

  ///Regular Dio

  // Navigator
  GetIt.instance.registerLazySingleton<INavigator>(() => NavigatorImpl());

  ///Register remote data source
  GetIt.instance.registerLazySingleton<IGlobalRemoteDatasource>(
    () => GlobalRemoteDatasourceImpl(dio: sl<IDioWrapper>()),
  );

  ///Register local data source
  GetIt.instance.registerLazySingleton<IGlobalLocalDataSource>(
    () => GlobalLocalDataSourceImpl(iSharedPreferenceService: sl<ISharedPreferenceService>()),
  );

  ///Register repository
  GetIt.instance.registerLazySingleton<IGlobalRepository>(
    () => GlobalRepositoryImpl(
      localDataSource: sl<IGlobalLocalDataSource>(),
      remoteDatasource: sl<IGlobalRemoteDatasource>(),
    ),
  );

  ///Common use-case
  GetIt.instance.registerLazySingleton<GetAccessTokenUseCase>(
    () => GetAccessTokenUseCase(repository: sl<IGlobalRepository>()),
  );

  GetIt.instance.registerLazySingleton<GetRefreshTokenUseCase>(
    () => GetRefreshTokenUseCase(repository: sl<IGlobalRepository>()),
  );
  GetIt.instance.registerLazySingleton<SaveAccessToken>(
    () => SaveAccessToken(globalRepository: sl<IGlobalRepository>()),
  );
  GetIt.instance.registerLazySingleton<SaveRefreshToken>(
    () => SaveRefreshToken(repository: sl<IGlobalRepository>()),
  );
  GetIt.instance.registerLazySingleton<ClearUserAccessTokensUseCase>(
    () => ClearUserAccessTokensUseCase(globalRepository: sl<IGlobalRepository>()),
  );
  GetIt.instance.registerLazySingleton<RefreshTokenApiUseCase>(
    () => RefreshTokenApiUseCase(repository: sl<IGlobalRepository>()),
  );

  _addDioLogInterceptors();
}

Future<void> _addDioLogInterceptors() async {
  Dio dio = sl<Dio>();

  if (!F.isProduction) {
    Alice alice = Alice(navigatorKey: navigatorKey);
    dio.interceptors.add(alice.getDioInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        request: kDebugMode,
        requestHeader: kDebugMode,
        requestBody: kDebugMode,
        responseHeader: kDebugMode,
        responseBody: kDebugMode,
      ),
    );
  }

  Map<String, String> apiHeaders = {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8',
  };

  ///Regular DIO
  dio.options.headers.addAll(apiHeaders);

  dio.interceptors.addAll([
    DioCustomInterceptors(
      dio: dio,
      getAccessTokenUseCase: sl<GetAccessTokenUseCase>(),
      getRefreshTokenUseCase: sl<GetRefreshTokenUseCase>(),
      saveAccessToken: sl<SaveAccessToken>(),
      saveRefreshToken: sl<SaveRefreshToken>(),
      clearUserAccessTokensUseCase: sl<ClearUserAccessTokensUseCase>(),
      refreshTokenApiUseCase: sl<RefreshTokenApiUseCase>(),
    ),
  ]);
}

class ShowAllLogsFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => kDebugMode;
}
