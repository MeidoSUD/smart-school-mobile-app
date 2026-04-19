import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ErrorMapper {
  static String translate(BuildContext context, String message) {
    final localizations = AppLocalizations.of(context)!;

    switch (message) {
      case "errorForbidden":
        return localizations.errorForbidden;
      case "errorUnauthorized":
        return localizations.errorUnauthorized;
      case "errorConnectionTimeout":
        return localizations.errorConnectionTimeout;
      case "errorReceiveTimeout":
        return localizations.errorReceiveTimeout;
      case "errorConnectionError":
        return localizations.errorConnectionError;
      case "errorServerError":
        return localizations.errorServerError;
      case "errorFormat":
        return localizations.errorFormat;
      case "errorGeneral":
        return localizations.errorGeneral;
      case "errorConnectionFailed":
        return localizations.errorConnectionFailed;
      case "errorNotFound":
        return localizations.errorNotFound;
      case "errorCredentials":
        return localizations.errorCredentials;
      case "errorUnexpected":
        return localizations.errorUnexpected;
      case "errorUserNotFound":
        return localizations.errorUserNotFound;
      case "User not found":
        return localizations.errorUserNotFound;
      case "validation.required":
        return localizations.requiredField;
      case "Registration validation failed":
        return localizations
            .errorOccurred; // Or a more specific one if available
      default:
        if (message.startsWith("BACKEND_ERROR:")) {
          final parts = message.substring("BACKEND_ERROR:".length).split("|");
          final en = parts.isNotEmpty ? parts[0] : "Error";
          final ar = parts.length > 1 ? parts[1] : en;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          return isArabic ? ar : en;
        }

        // Try to handle translation tags if they come from backend
        if (message.contains("validation.required")) {
          return localizations.requiredField;
        }
        // If it's not a known key, return as is (might be backend message)
        return message;
    }
  }
}
