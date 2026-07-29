import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsService {
  SharePrefsService._internal();
  static final _instance = SharePrefsService._internal();
  factory SharePrefsService() => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;

  static const _keyGridMode = 'isGridMode';
  static const _keyThemeColor = 'user_theme_color';

  Future<void> saveGridMode(bool isGrid) async {
    await prefs.setBool(_keyGridMode, isGrid);
  }

  Future<bool> loadGridMode() async {
    return prefs.getBool(_keyGridMode) ?? true;
  }

  Future<void> saveThemeColor(String hexColor) async {
    await prefs.setString(_keyThemeColor, hexColor);
  }

  Future<String> loadThemeColor() async {
    return prefs.getString(_keyThemeColor) ?? '#FF5722';
  }
}