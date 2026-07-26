import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _firstLaunchKey = 'isFirstLaunch';
  static const String _themeModeKey = 'themeMode';

  PreferencesService._internal();
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;

  Future<void> setFirstLaunch(bool isFirst) async {
    await prefs.setBool(_firstLaunchKey, isFirst);
  }

  Future<bool> getFirstLaunch() async {
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> setThemeMode(String theme) async {
    await prefs.setString(_themeModeKey, theme);
  }

  Future<String> getThemeMode() async {
    return prefs.getString(_themeModeKey) ?? 'Light';
  }
}