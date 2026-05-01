import 'package:dio/dio.dart';
import 'logger.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      final response = error.response;
      
      if (response != null) {
        final data = response.data;
        final statusCode = response.statusCode;
        
        // Handle specific status codes
        switch (statusCode) {
          case 401:
            return 'Invalid username or password';
          case 403:
            return 'Access denied';
          case 404:
            return 'Resource not found';
          case 422:
            return _extractValidationError(data);
          case 500:
            return 'Server error. Please try again later';
          default:
            return _extractMessage(data) ?? 'Something went wrong';
        }
      }
      
      // Connection errors
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Check your internet';
        case DioExceptionType.receiveTimeout:
          return 'Server not responding';
        case DioExceptionType.connectionError:
          return 'No internet connection';
        default:
          return 'Network error. Please try again';
      }
    }
    
    if (error is Exception) {
      final msg = error.toString();
      if (msg.contains('Exception: ')) {
        return msg.substring(11);
      }
      Logger.recordError(error, StackTrace.current, reason: 'Unhandled Exception');
      return 'Something went wrong';
    }
    
    Logger.recordError(error, StackTrace.current, reason: 'Unhandled Error');
    return 'Unexpected error occurred';
  }
  
  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      return data['message']?.toString();
    }
    if (data is String && data.isNotEmpty) {
      return data;
    }
    return null;
  }
  
  static String _extractValidationError(dynamic data) {
    if (data is Map && data['errors'] is Map) {
      final errors = data['errors'] as Map;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }
        return firstError.toString();
      }
    }
    return 'Validation error';
  }
}