import 'package:flutter/material.dart';

// Global key for ScaffoldMessenger (used for SnackBars, etc.)
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Global key for Navigator (used for navigation without context)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
