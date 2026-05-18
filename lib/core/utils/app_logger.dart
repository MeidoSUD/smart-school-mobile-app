import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message, {String tag = 'App'}) {
    if (kDebugMode) {
      developer.log(message, name: tag);
    }
  }
  
  static void error(String message, {String tag = 'Error'}) {
    if (kDebugMode) {
      developer.log(message, name: tag, level: 1000);
    }
  }
}
