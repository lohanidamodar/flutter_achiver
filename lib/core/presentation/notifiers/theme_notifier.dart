import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "dark_theme";
  SharedPreferences prefs;
  ThemeData _lightTheme=ThemeData(
    scaffoldBackgroundColor: bgColor,
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16.0),
    )
  );
  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
    accentColor: Colors.pink,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16.0)
    ),
  );

  ThemeData currentTheme;

  bool darkTheme;

  ThemeNotifier() {
    currentTheme = _darkTheme;
    darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    currentTheme = darkTheme ? _lightTheme : _darkTheme;
    darkTheme = !darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    darkTheme = prefs.getBool(key) ?? true;
    currentTheme = darkTheme ? _darkTheme : _lightTheme;
    notifyListeners();
  }
  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, darkTheme);
  }
  _initPrefs() async {
    if(prefs== null)
      prefs = await SharedPreferences.getInstance();
  }
}
