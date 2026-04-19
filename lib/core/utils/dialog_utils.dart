import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../../l10n/app_localizations.dart';
import 'error_handler.dart';

class DialogUtils {
  /// Extracts the appropriate error message from a DioException or general error
  /// Handles both localized messages (message_en/message_ar) and default error keys
  static String getErrorMessage(BuildContext context, dynamic error) {
    // Get current locale
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';

    // Try to extract localized message from the last error response
    final lastError = ErrorHandler.getLastErrorResponse();
    if (lastError is Map<String, dynamic>) {
      // Priority 1: Check for bilingual messages (message_en/message_ar)
      if (isArabic && lastError.containsKey('message_ar')) {
        final message = lastError['message_ar'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      } else if (!isArabic && lastError.containsKey('message_en')) {
        final message = lastError['message_en'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      }

      // Priority 2: Fallback to opposite language if available
      if (isArabic && lastError.containsKey('message_en')) {
        final message = lastError['message_en'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      } else if (!isArabic && lastError.containsKey('message_ar')) {
        final message = lastError['message_ar'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      }

      // Priority 3: Check for generic message field
      if (lastError.containsKey('message')) {
        final message = lastError['message'];
        if (message != null && message.toString().isNotEmpty) {
          return message.toString();
        }
      }
    }

    // Handle DioException
    if (error is DioException) {
      // Check if response has data
      if (error.response?.data != null) {
        try {
          final data = error.response!.data;
          Map<String, dynamic> jsonData;

          // Parse if it's a string
          if (data is String) {
            jsonData = json.decode(data);
          } else if (data is Map<String, dynamic>) {
            jsonData = data;
          } else {
            return _getDefaultErrorMessage(context);
          }

          // Extract localized message based on app language
          if (isArabic && jsonData.containsKey('message_ar')) {
            final msg = jsonData['message_ar'];
            if (msg != null && msg.toString().isNotEmpty) {
              return msg.toString();
            }
          } else if (!isArabic && jsonData.containsKey('message_en')) {
            final msg = jsonData['message_en'];
            if (msg != null && msg.toString().isNotEmpty) {
              return msg.toString();
            }
          }

          // Fallback: Use opposite language
          if (isArabic && jsonData.containsKey('message_en')) {
            final msg = jsonData['message_en'];
            if (msg != null && msg.toString().isNotEmpty) {
              return msg.toString();
            }
          } else if (!isArabic && jsonData.containsKey('message_ar')) {
            final msg = jsonData['message_ar'];
            if (msg != null && msg.toString().isNotEmpty) {
              return msg.toString();
            }
          }

          // Generic message fallback
          if (jsonData.containsKey('message')) {
            final msg = jsonData['message'];
            if (msg != null && msg.toString().isNotEmpty) {
              return msg.toString();
            }
          }
        } catch (e) {
          // If parsing fails, return default message
          return _getDefaultErrorMessage(context);
        }
      }

      // Handle different DioException types
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return isArabic
              ? 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.'
              : 'Connection timeout. Please try again.';
        case DioExceptionType.connectionError:
          return isArabic
              ? 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال.'
              : 'No internet connection. Please check your connection.';
        case DioExceptionType.badResponse:
          return _getDefaultErrorMessage(context);
        default:
          return _getDefaultErrorMessage(context);
      }
    }

    // Handle general exceptions
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }

    // Return error as string if it's already a string
    if (error is String) {
      return error;
    }

    return _getDefaultErrorMessage(context);
  }

  static String _getDefaultErrorMessage(BuildContext context) {
    return AppLocalizations.of(context)!.unexpectedError;
  }

  static void showFriendlyErrorDialog(
    BuildContext context, {
    String? message,
    dynamic error,
    String? title,
    VoidCallback? onRetry,
    VoidCallback? onOk,
  }) {
    // Determine the error message to display
    final errorMessage =
        message ??
        (error != null
            ? getErrorMessage(context, error)
            : _getDefaultErrorMessage(context));

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red.shade400,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title ?? AppLocalizations.of(context)!.error,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onRetry != null) ...[
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onRetry();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(AppLocalizations.of(context)!.retry),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onOk != null) onOk();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(AppLocalizations.of(context)!.ok),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Convenience method specifically for API errors
  static void showApiErrorDialog(
    BuildContext context, {
    required dynamic error,
    String? title,
    VoidCallback? onRetry,
    VoidCallback? onOk,
  }) {
    showFriendlyErrorDialog(
      context,
      error: error,
      title: title,
      onRetry: onRetry,
      onOk: onOk,
    );
  }
}
