import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../core/base/services/global_usecases/clear_user_access_tokens.dart';
import '../../core/base/services/global_usecases/get_access_token_usecase.dart';
import '../../core/base/services/global_usecases/save_access_token.dart';
import '../../routes/app_pages.dart';
import '../../utils/constansts/global.dart';
import '../model/base/base_interfaces/i_usecase.dart';
import 'api_path.dart';

class DioCustomInterceptors extends Interceptor {
  final Dio dio;
  final GetAccessTokenUseCase getAccessTokenUseCase;
  final SaveAccessToken saveAccessToken;
  final ClearUserAccessTokensUseCase clearUserAccessTokensUseCase;

  DioCustomInterceptors({
    required this.dio,
    required this.getAccessTokenUseCase,
    required this.saveAccessToken,
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
      _forceLogout();
      return;
    }

    handler.next(err);
  }

  Future<void> _forceLogout() async {
    final context = navigatorKey.currentState?.context;
    await clearUserAccessTokensUseCase.call(NoParams());
    context?.go(Routes.login);
  }
}
