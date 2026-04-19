import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Key for storing language preference
const String _languageKey = 'language_code';

// Constants for supported locales
const Locale kEnglishLocale = Locale('en');
const Locale kArabicLocale = Locale('ar');

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(kArabicLocale) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_languageKey);

    if (languageCode != null) {
      state = Locale(languageCode);
    } else {
      // Default to Arabic if no preference is saved
      state = kArabicLocale;
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
  }

  // Helper method to toggle between Ar/En
  Future<void> toggleLocale() async {
    if (state.languageCode == 'en') {
      await setLocale(kArabicLocale);
    } else {
      await setLocale(kEnglishLocale);
    }
  }
}
