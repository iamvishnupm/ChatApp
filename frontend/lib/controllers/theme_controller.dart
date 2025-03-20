import 'package:flutter/material.dart';
import 'package:frontend/data/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeControl extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  ThemeControl() {
    _init();
  }

  Future<void> _init() async {
    await _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _themeData = _isDarkMode ? darkMode : lightMode;

    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkMode : lightMode;

    _saveTheme();
    notifyListeners();
  }
}
