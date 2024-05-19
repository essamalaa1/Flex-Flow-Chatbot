import 'package:flutter/material.dart';

enum AppTheme {
  // ignore: constant_identifier_names
  Light,
  // ignore: constant_identifier_names
  Dark,
}

class ThemeProvider extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.Light;

  AppTheme get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme =
        _currentTheme == AppTheme.Light ? AppTheme.Dark : AppTheme.Light;
    notifyListeners();
  }

  ThemeData getThemeData() {
    switch (_currentTheme) {
      case AppTheme.Light:
        return ThemeData.light().copyWith(
            primaryColor: const Color(0xffC89116),
            brightness: Brightness.light);
      case AppTheme.Dark:
        return ThemeData.dark().copyWith(
            primaryColor: Colors.grey[800], brightness: Brightness.light);
    }
  }
}
