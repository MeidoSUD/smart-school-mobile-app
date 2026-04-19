import 'package:dio/dio.dart';

import 'logger.dart';

class ErrorHandler {
  /// Store the raw error response for later use with context
  static dynamic _lastErrorResponse;

  /// Get the last error response (used for extracting localized messages)
  static dynamic getLastErrorResponse() => _lastErrorResponse;

  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      final response = error.response;

      if (response != null) {
        final data = response.data;

        // 🌍 STORE raw response for context-aware message extraction
        _lastErrorResponse = data;

        // ⛔ Handle Forbidden (403)
        if (response.statusCode == 403) {
          return "errorForbidden";
        }

        // 🔑 Handle Unauthorized (401)
        if (response.statusCode == 401) {
          return "errorUnauthorized";
        }

        // 🔄 Handle Conflict (409) - e.g. Already Registered
        // Check this BEFORE bilingual messages to handle special cases
        if (response.statusCode == 409) {
          if (data is Map) {
            // If has bilingual messages, return them
            if (data['message_en'] != null || data['message_ar'] != null) {
              final en = data['message_en'] ?? data['message'] ?? "Error";
              final ar = data['message_ar'] ?? data['message'] ?? "خطأ";
              return "BACKEND_ERROR:$en|$ar";
            }
            // Otherwise check for specific error code
            if (data['code'] == 'ALREADY_REGISTERED')
              return "ALREADY_REGISTERED";
          }
        }

        // 🌍 PRIORITIZE: Check for bilingual messages
        if (data is Map) {
          if (data['message_en'] != null || data['message_ar'] != null) {
            final en = data['message_en'] ?? data['message'] ?? "Error";
            final ar = data['message_ar'] ?? data['message'] ?? "خطأ";
            return "BACKEND_ERROR:$en|$ar";
          }
        }

        // 🟡 Handle Laravel validation errors (422)
        if (response.statusCode == 422 && data is Map<String, dynamic>) {
          // If there are specific field errors, prioritize them
          if (data['errors'] != null && data['errors'] is Map) {
            final errors = data['errors'] as Map;

            // Check for specific "exists" or "taken" errors to trigger "Account exists" flow
            bool isTaken = false;
            errors.forEach((key, value) {
              final msgs = value.toString().toLowerCase();
              if (msgs.contains("taken") ||
                  msgs.contains("already exists") ||
                  msgs.contains("مستخدم") ||
                  msgs.contains("موجود")) {
                isTaken = true;
              }
            });
            if (isTaken) return "ALREADY_REGISTERED";

            // Return input validation errors
            if (errors.isNotEmpty) {
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return "VALIDATION_ERROR:${firstError.first}";
              } else if (firstError is String) {
                return "VALIDATION_ERROR:$firstError";
              }
            }
          }
          // Fallback to top-level message
          // Check for code first
          if (data['code'] == 'ALREADY_REGISTERED') return "ALREADY_REGISTERED";

          if (data['message'] != null) {
            final msg = data['message'].toString();
            if (msg.toLowerCase().contains("unverified") ||
                msg.contains("not verified")) {
              return "UNVERIFIED_USER";
            }
            return "VALIDATION_ERROR:$msg";
          }
        }

        // 🆕 Handle Custom API Error format (success: false)
        if (data is Map && data['success'] == false) {
          if (data['code'] == 'ALREADY_REGISTERED') return "ALREADY_REGISTERED";
          if (data['code'] == 'UNVERIFIED_USER') return "UNVERIFIED_USER";

          if (data['message'] != null) {
            return data['message'].toString();
          }
        }

        // 🔴 General Laravel error message
        if (data is Map && data['message'] != null) {
          return getMessageBasedOnContent(data['message'].toString());
        }

        // 🔵 Response is plain string
        if (data is String) return getMessageBasedOnContent(data);

        // 🔘 Unknown structured error
        return "errorUnexpected";
      }

      // 🌐 Connection errors
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "errorConnectionTimeout";
        case DioExceptionType.receiveTimeout:
          return "errorReceiveTimeout";
        case DioExceptionType.connectionError:
          return "errorConnectionError";
        default:
          return "errorServerError";
      }
    }

    if (error is FormatException) {
      Logger.recordError(
        error,
        StackTrace.current,
        reason: 'FormatException in ErrorHandler',
      );
      return "errorFormat";
    }

    if (error is Exception) {
      final msg = error.toString();
      if (msg.startsWith('Exception: ')) {
        return msg.substring(11);
      }
      Logger.recordError(
        error,
        StackTrace.current,
        reason: 'Unhandled Exception in ErrorHandler',
      );
      return "errorUnexpected";
    }

    // 🧩 Fallback for Error (like TypeError)
    if (error is Error) {
      Logger.recordError(
        error,
        StackTrace.current,
        reason: 'TypeError or internal Error in ErrorHandler',
      );
      return "errorUnexpected";
    }

    // 🧩 Final Fallback
    Logger.recordError(
      error,
      StackTrace.current,
      reason: 'Total Fallback in ErrorHandler',
    );
    return "errorUnexpected";
  }

  static String getMessageBasedOnContent(dynamic message) {
    if (message.toLowerCase().contains("connection") ||
        message.toLowerCase().contains("network") ||
        message.toLowerCase().contains("socket") ||
        message.toLowerCase().contains("failed to connect") ||
        message.toLowerCase().contains("host unreachable") ||
        message.toLowerCase().contains("503")) {
      return "errorConnectionFailed";
    }
    if (message.toLowerCase().contains("timeout")) {
      return "errorConnectionTimeout";
    }
    if (message.toLowerCase().contains("unauthorized")) {
      return "errorUnauthorized";
    }
    if (message.toLowerCase().contains("not found")) {
      return "errorNotFound";
    }
    if (message.toLowerCase().contains("credentials are incorrect")) {
      return "errorCredentials";
    }
    return message; // Default to the original message if no match is found
  }
}
