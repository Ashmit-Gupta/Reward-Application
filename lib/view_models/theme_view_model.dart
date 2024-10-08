import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  ThemeData get themeData => _isDarkMode
      ? ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        )
      : ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        );
}
