import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF3A86FF, // Your desired color #3A86FF
    {
      50: Color(0xFFE6F0FF),
      100: Color(0xFFBDD9FF),
      200: Color(0xFF94C2FF),
      300: Color(0xFF6BABFF),
      400: Color(0xFF4D98FF),
      500: Color(0xFF3A86FF),
      600: Color(0xFF347EE6),
      700: Color(0xFF2B73BF),
      800: Color(0xFF236799),
      900: Color(0xFF184D73),
    },
  );

  static ThemeData lightTheme = ThemeData(
    primarySwatch: primarySwatch,
    primaryColor: primarySwatch[500],
    primaryColorLight: primarySwatch[200],
    primaryColorDark: primarySwatch[700],

    cardColor: const Color(0xFFEEEEEE),
    textTheme: const TextTheme(
      labelMedium: TextStyle(fontSize: 16, color: Colors.grey),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodySmall: TextStyle(fontSize: 14, color: Colors.grey),
      labelSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
