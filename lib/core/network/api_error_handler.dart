import 'package:dio/dio.dart';
import 'api_error_model.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    return ApiErrorModel(
      message: error.toString(),
      code: DataSource.defaultError.index,
    );
  }

  static ApiErrorModel _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiErrorModel(
          message: 'Connection timeout',
          code: DataSource.connectTimeout.index,
        );
      case DioExceptionType.badResponse:
        return ApiErrorModel(
          message: error.response?.data?['message'] ?? 'Server error',
          code: error.response?.statusCode ?? DataSource.defaultError.index,
        );
      case DioExceptionType.cancel:
        return ApiErrorModel(
          message: 'Request cancelled',
          code: DataSource.cancel.index,
        );
      case DioExceptionType.unknown:
        return ApiErrorModel(
          message: 'Network error',
          code: DataSource.noInternetConnection.index,
        );
      default:
        return ApiErrorModel(
          message: 'Something went wrong',
          code: DataSource.defaultError.index,
        );
    }
  }
  
  static String getErrorMessage(dynamic error) {
    return handle(error).message;
  }
}
