import 'package:flutter/widgets.dart';

final Color bgColor = Color(0xfff2f2f2);
final Color borderColor = Color(0xffd6d6d6);
final Color primaryColor = Color(0xff51be91);
final Color accentColor = Color(0xff6052bd);

final fbBgColor=Color(0xff3e68e0);
final fbFgColor=Color(0xff475993);
final googleBgColor=Color(0xffd9e7fd);
final googleFgColor=Color(0xff4487f4);

final Gradient primaryGradient = LinearGradient(
  colors: [
    accentColor,
    primaryColor,
  ]
);
final Gradient splashGradient = LinearGradient(
  colors: [
    accentColor,
    primaryColor,
  ],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);