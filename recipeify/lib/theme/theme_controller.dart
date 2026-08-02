import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  static const _prefKey = 'is_dark_mode';
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_prefKey);

    if (saved == null) {
      final systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _themeMode = systemBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = saved ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, value);
  }
}