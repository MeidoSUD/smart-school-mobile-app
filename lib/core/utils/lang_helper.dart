import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LangHelper {
  static const String _key = 'lang';
  static const String arabic = 'ar';
  static const String english = 'en';

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_key);
    if (lang != null) {
      return Locale(lang);
    }
    return const Locale(english);
  }

  static Future<void> saveLocale(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, langCode);
  }

  static bool isArabic(Locale? locale) {
    return locale?.languageCode == arabic;
  }
}
