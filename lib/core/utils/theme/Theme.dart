import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
class GAppTheme {
  GAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'ReadexPro',
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    textTheme: GTextTheme.lightTextTheme


  );
  static ThemeData darkTheme = ThemeData(
     useMaterial3: true,
    fontFamily: 'ReadexPro',
    brightness: Brightness.dark,
    primaryColor: Color(0xFFFFFFFF),
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: GTextTheme.darkTextTheme

  );
}
