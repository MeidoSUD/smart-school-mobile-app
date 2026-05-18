import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    if (kDebugMode) {
      debugPrint('🟢 $message');
    }
  }

  static void recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      debugPrint('🔴 Error: $exception');
      if (stack != null) debugPrint('Stack: $stack');
    } else {
      FirebaseCrashlytics.instance.recordError(
        exception,
        stack,
        reason: reason,
        fatal: fatal,
      );
    }
  }
}
