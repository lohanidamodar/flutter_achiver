import 'package:flutter/material.dart';
import 'package:flutter_achiver/core/presentation/res/colors.dart' as prefix0;

class ThemeNotifier extends ChangeNotifier {
  ThemeData _lightTheme=ThemeData(
    scaffoldBackgroundColor: prefix0.bgColor,
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
  }

  toggleTheme() {
    currentTheme = darkTheme ? _lightTheme : _darkTheme;
    darkTheme = !darkTheme;
    notifyListeners();
  }
}
