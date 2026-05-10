import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../utils/manager/network/network_info.dart';
import '../model/base/errors/failures.dart';
import 'api_path.dart';
import 'dio_error_handler.dart';

abstract class IDioWrapper {
  Future<Response<dynamic>> onPost({
    required APIModel api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  });

  Future<Response<dynamic>> onPut({
    required APIModel api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onPatch({
    required APIModel api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onGet({
    required APIModel api,
    Options? options,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onDelete({
    required APIModel api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  void resolveAPIMetadata({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onMockResponse(String mockAPI);
}

class DioWrapperImpl extends IDioWrapper {
  final Dio _dio;
  final DioErrorHandler _dioErrorHandler;
  final INetworkInfo _networkInfo;

  DioWrapperImpl({
    required Dio dio,
    required DioErrorHandler dioErrorHandler,
    required INetworkInfo networkInfo,
  }) : _dio = dio,
       _dioErrorHandler = dioErrorHandler,
       _networkInfo = networkInfo;

  Future<Response> _handleOffline(String endpoint) async {
    throw const NetworkFailure(message: "No Internet Connection");
  }

  Future<Response> _performRequest(
    String method,
    APIModel api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers, {
    Options? options,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    if (api.isMock) {
      return onMockResponse(api.mockJsonEndPoint);
    }

    if (!await _networkInfo.isConnected) {
      return _handleOffline(api.apiEndPoint);
    }

    try {
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      switch (method) {
        case 'GET':
          return await _dio.get(api.apiEndPoint, options: options);
        case 'POST':
          return await _dio.post(
            api.apiEndPoint,
            data: data,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
          );
        case 'PUT':
          return await _dio.put(api.apiEndPoint, data: data);
        case 'PATCH':
          return await _dio.patch(api.apiEndPoint, data: data);
        case 'DELETE':
          return await _dio.delete(api.apiEndPoint, data: data);
        default:
          throw UnimplementedError('HTTP method $method is not implemented');
      }
    } on DioException catch (e) {
      debugPrint('[ON $method | DIO ERROR | API ${api.apiEndPoint}] ${e.response}');
      throw _dioErrorHandler.resolveErrors(exception: e);
    } catch (e) {
      debugPrint('[ON $method | SOMETHING GOES WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response> onGet({
    required APIModel api,
    Options? options,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _performRequest('GET', api, null, queryParameters, headers, options: options);

  @override
  Future<Response> onPost({
    required APIModel api,
    required data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) => _performRequest(
    'POST',
    api,
    data,
    queryParameters,
    headers,
    onSendProgress: onSendProgress,
    cancelToken: cancelToken,
  );

  @override
  Future<Response> onPut({
    required APIModel api,
    required data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _performRequest('PUT', api, data, queryParameters, headers);

  @override
  Future<Response> onPatch({
    required APIModel api,
    required data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _performRequest('PATCH', api, data, queryParameters, headers);

  @override
  Future<Response> onDelete({
    required APIModel api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => _performRequest('DELETE', api, data, queryParameters, headers);

  @override
  void resolveAPIMetadata({Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    _dio.options.queryParameters.clear();
    if (queryParameters != null) {
      _dio.options.queryParameters.addAll(queryParameters);
    }
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
  }

  @override
  Future<Response> onMockResponse(String mockAPI) async {
    await Future.delayed(const Duration(seconds: 3));
    final result = await rootBundle.loadString(mockAPI);
    return Response(data: json.decode(result), statusCode: 200, requestOptions: RequestOptions());
  }
}
