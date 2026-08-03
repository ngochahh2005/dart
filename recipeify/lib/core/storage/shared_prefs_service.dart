import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._internal();
  static final _instance = SharedPrefsService._internal();
  factory SharedPrefsService() => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const _keyDarkMode = 'isDarkMode';
  static const _keyGridView = 'isGridView';

  Future<void> saveDarkMode(bool isDarkMode) async {
    await _prefs.setBool(_keyDarkMode, isDarkMode);
  }

  Future<bool> loadDarkMode() async {
    return _prefs.getBool(_keyDarkMode) ?? false;
  }

  Future<void> saveGridView(bool isGridView) async {
    await _prefs.setBool(_keyGridView, isGridView);
  }

  Future<bool> loadGridView() async {
    return _prefs.getBool(_keyGridView) ?? true;
  }
}