import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../core/base/services/data/params/refresh_token_request_params.dart';
import '../../core/base/services/global_usecases/clear_user_access_tokens.dart';
import '../../core/base/services/global_usecases/get_access_token_usecase.dart';
import '../../core/base/services/global_usecases/get_refresh_token_usecase.dart';
import '../../core/base/services/global_usecases/refresh_token_api_usecase.dart';
import '../../core/base/services/global_usecases/save_access_token.dart';
import '../../core/base/services/global_usecases/save_refresh_token.dart';
import '../../utils/constansts/global.dart';
import '../model/base/base_interfaces/i_usecase.dart';
import 'api_path.dart';

class DioCustomInterceptors extends Interceptor {
  final Dio dio;
  final RefreshTokenApiUseCase refreshTokenApiUseCase;
  final GetAccessTokenUseCase getAccessTokenUseCase;
  final GetRefreshTokenUseCase getRefreshTokenUseCase;
  final SaveAccessToken saveAccessToken;
  final SaveRefreshToken saveRefreshToken;
  final ClearUserAccessTokensUseCase clearUserAccessTokensUseCase;

  DioCustomInterceptors({
    required this.dio,
    required this.refreshTokenApiUseCase,
    required this.getAccessTokenUseCase,
    required this.getRefreshTokenUseCase,
    required this.saveAccessToken,
    required this.saveRefreshToken,
    required this.clearUserAccessTokensUseCase,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final result = await getAccessTokenUseCase(NoParams());
    result.fold(
      (left) {},
      (right) {
        if (right.isNotEmpty) options.headers['Authorization'] = 'Bearer $right';
      },
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.response?.realUri.path ?? '';

    if (path.contains(APIPaths.login.apiEndPoint)) {
      return handler.next(err);
    }

    if (statusCode == 401) {
      try {
        final result = await getAccessTokenUseCase.call(NoParams());
        final token = result.getOrElse(() => '');

        if (token.isNotEmpty) {
          final newToken = await _getNewAccessToken();

          if (newToken.isEmpty) {
            _forceLogout();
            return;
          }

          final clonedResponse = await _retry(err.requestOptions, newToken);
          return handler.resolve(clonedResponse);
        } else {
          _forceLogout();
          return;
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          _forceLogout();
          return;
        }

        return handler.next(e);
      } catch (e) {
        _forceLogout();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<void> _forceLogout() async {
    final context = navigatorKey.currentState?.context;
    await clearUserAccessTokensUseCase.call(NoParams());
    context?.go('Routes.login');
  }

  Future<String> _getNewAccessToken() async {
    final refreshTokenEither = await getRefreshTokenUseCase.call(NoParams());

    if (refreshTokenEither.isLeft()) {
      return "";
    }

    final data = refreshTokenEither.getOrElse(() => "");

    RefreshTokenRequestParams params = RefreshTokenRequestParams(refreshToken: data);

    final resultEither = await refreshTokenApiUseCase.call(params);
    if (resultEither.isLeft()) {
      return "";
    }

    // final newTokenData = resultEither.getOrElse(() => RefreshTokenResponseModel.empty());
    //
    // saveAccessToken.call(newTokenData.data.accessToken);
    // saveRefreshToken.call(newTokenData.data.refreshToken);
    //
    // return newTokenData.data.accessToken;
    return '';
  }

  /// Safely retry a failed request (including FormData)
  Future<Response<dynamic>> _retry(RequestOptions requestOptions, String newToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      validateStatus: requestOptions.validateStatus,
      followRedirects: requestOptions.followRedirects,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      extra: requestOptions.extra,
    );

    dynamic data = requestOptions.data;

    if (data is FormData) {
      final newFormData = FormData();

      // Re-add fields
      newFormData.fields.addAll(data.fields);

      // Clone files (important part!)
      for (final file in data.files) {
        final field = file.key;
        final multipart = file.value;

        newFormData.files.add(
          MapEntry(
            field,
            multipart.clone(),
          ),
        );
      }

      data = newFormData;
    }

    return dio.request<dynamic>(
      requestOptions.path,
      data: data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
