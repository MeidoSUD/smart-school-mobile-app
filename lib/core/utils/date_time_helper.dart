import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Formats a date string (e.g., "2025-11-28") to "Fri, 28 Nov 2025" (in English)
  /// Returns the original string if parsing fails.
  static String formatDate(BuildContext context, String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final locale = Localizations.localeOf(context).languageCode;
      final parsed = DateTime.parse(dateString);
      return DateFormat('E, d MMM yyyy').format(parsed);
    } catch (_) {
      return dateString;
    }
  }

  /// Formats a time string (e.g., "14:30") to "2:30 PM" (in English)
  /// Returns the original string if parsing fails.
  /// If [dateString] is provided, it combines it with the time.
  static String formatTime(
    BuildContext context,
    String? timeString, {
    String? dateString,
  }) {
    if (timeString == null || timeString.isEmpty) return 'N/A';
    try {
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        DateTime dateBase = DateTime.now();
        if (dateString != null && dateString.isNotEmpty) {
          try {
            dateBase = DateTime.parse(dateString);
          } catch (_) {}
        }

        final dt = DateTime(
          dateBase.year,
          dateBase.month,
          dateBase.day,
          hour,
          minute,
        );

        return DateFormat('h:mm a').format(dt);
      }
    } catch (e) {
      // Fallback
    }
    return timeString;
  }

  static SessionState getSessionStatus(
    String? dateStr,
    String? startTimeStr,
    String? endTimeStr, {
    int startBufferMinutes = 0,
  }) {
    if (dateStr == null || startTimeStr == null || endTimeStr == null)
      return SessionState.upcoming;

    try {
      final now = DateTime.now();

      // Parse Date
      DateTime dateBase;
      try {
        dateBase = DateTime.parse(dateStr);
      } catch (_) {
        return SessionState.upcoming;
      }

      // Parse Start Time
      final startParts = startTimeStr.split(':');
      final startDt = DateTime(
        dateBase.year,
        dateBase.month,
        dateBase.day,
        int.parse(startParts[0]),
        int.parse(startParts[1]),
      );

      // Parse End Time
      final endParts = endTimeStr.split(':');
      var endDt = DateTime(
        dateBase.year,
        dateBase.month,
        dateBase.day,
        int.parse(endParts[0]),
        int.parse(endParts[1]),
      );

      // Handle overnight sessions if needed
      if (endDt.isBefore(startDt)) {
        endDt = endDt.add(const Duration(days: 1));
      }

      if (now.isBefore(
        startDt.subtract(Duration(minutes: startBufferMinutes)),
      )) {
        return SessionState.upcoming;
      } else if (now.isAfter(endDt)) {
        return SessionState.finished;
      } else {
        return SessionState.live;
      }
    } catch (_) {
      return SessionState.upcoming;
    }
  }

  static String getDuration(
    BuildContext context,
    String? startTimeStr,
    String? endTimeStr,
  ) {
    if (startTimeStr == null || endTimeStr == null) return '';

    try {
      final startParts = startTimeStr.split(':');
      final endParts = endTimeStr.split(':');

      final startH = int.parse(startParts[0]);
      final startM = int.parse(startParts[1]);
      final endH = int.parse(endParts[0]);
      final endM = int.parse(endParts[1]);

      var diffMinutes = (endH * 60 + endM) - (startH * 60 + startM);
      if (diffMinutes < 0) diffMinutes += 24 * 60;

      final hours = diffMinutes ~/ 60;
      final minutes = diffMinutes % 60;

      final l10n = AppLocalizations.of(context)!;
      final buffer = StringBuffer();

      if (hours > 0) {
        buffer.write('$hours ${l10n.hour}');
      }
      if (minutes > 0) {
        if (hours > 0) buffer.write(l10n.and);
        buffer.write('$minutes ${l10n.minute}');
      }

      return buffer.toString();
    } catch (_) {
      return '';
    }
  }
}

enum SessionState { upcoming, live, finished }
