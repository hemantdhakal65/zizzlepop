import 'package:flutter/foundation.dart';

class Logger {
  static void error(String message) {
    debugPrint('🔴 ERROR: $message');
  }

  static void info(String message) {
    debugPrint('🔵 INFO: $message');
  }

  static void warning(String message) {
    debugPrint('🟠 WARNING: $message');
  }
}