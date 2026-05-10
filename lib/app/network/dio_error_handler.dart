import 'package:dio/dio.dart';

import '../model/base/errors/failures.dart';

abstract class DioErrorHandler {
  Failure resolveErrors({required DioException exception});

  Failure throwDefaultFailure();
}

class DioErrorHandlerImpl extends DioErrorHandler {
  @override
  Failure resolveErrors({required DioException exception}) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeOutError(message: "CONNECTION TIMEOUT");
      case DioExceptionType.badResponse:
        if (exception.response != null && exception.response?.statusCode != null && exception.response?.statusMessage != null) {
          return _handleBadResponse(response: exception.response!);
        } else {
          return throwDefaultFailure();
        }
      case DioExceptionType.cancel:
        return const CancelError(message: "Process has been cancelled");
      default:
        return throwDefaultFailure();
    }
  }

  @override
  Failure throwDefaultFailure() {
    return const DioDefaultFailure(message: "Something went wrong");
  }

  Failure _handleBadResponse({required Response<dynamic> response}) {
    switch (response.statusCode) {
      case 501:
      case 500:
        return DioInternalError(message: response.data?["msg"] ?? "Internal error");
      case 404:
        return DioNotFoundError(message: response.data?["msg"] ?? "Not found");
      case 204:
        return DioContentNotFound(message: response.data?["msg"] ?? "Content not found");
      case 400:
        return DioUnAuthorized(message: response.data?["msg"] ?? "Something went wrong");
      case 401:
        return DioUnAuthorized(message: response.data?["msg"] ?? "Un-Authorized Request");
      case 403:
        return DioUnAuthorized(message: response.data?["msg"] ?? "Something went wrong");
      case 409:
        return ResourceAlreadyExists(message: response.data?["msg"] ?? "Already Exists");
      case 422:
        return UnprocessableEntity(
          message: response.data?["msg"] ?? "Unprocessable Entity",
          errors: response.data?["errors"] ?? {},
        );
      case 503:
        return const ServiceUnavailableFailure(message: "Server not available");
      default:
        return const DioDefaultFailure(message: "Something went wrong");
    }
  }
}
