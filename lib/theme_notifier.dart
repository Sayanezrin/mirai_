import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData); // Constructor with a ThemeData parameter

  ThemeData get themeData => _themeData;

  // Method to toggle between light and dark themes
  void toggleTheme() {
    if (_themeData.brightness == Brightness.dark) {
      _themeData = ThemeData.light();
    } else {
      _themeData = ThemeData.dark();
    }
    notifyListeners();
  }
}
