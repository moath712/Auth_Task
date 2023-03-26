import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  late SharedPreferences prefs;
  Future<UserManager> initState() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  late Locale appLang;
  late ThemeMode appTheme;
  late String idToken;

  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal() {
    initState();
  }

  Future<String> getAppLanguage() async {
    var lang = await getString('AppLang') ?? 'en';
    UserManager().appLang = Locale(lang);
    appLang = Locale(lang);

    return lang;
  }

  Future<String> getAppTheme() async {
    String? theme = await getString('AppTheme') ?? ' ';
    if (theme == 'dark') {
      appTheme = ThemeMode.dark;
    } else if (theme == 'light') {
      appTheme = ThemeMode.light;
    } else {
      appTheme = ThemeMode.light;
    }
    return theme;
  }

  void setAppLanguage(String lang) {
    appLang = Locale(lang);
    setString('AppLang', lang);
  }

  void setAppTheme(ThemeMode theme) {
    appTheme = theme;
    if (theme == ThemeMode.dark) {
      setString('AppTheme', 'dark');
    } else {
      setString('AppTheme', 'light');
    }
  }

  void setUser(String token) {
    idToken = token;
    setString('Token', token);
  }

  void setString(String key, String? value) {
    if (value == null) {
      prefs.remove(key);
      return;
    }
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return prefs.getString(key);
  }
}
