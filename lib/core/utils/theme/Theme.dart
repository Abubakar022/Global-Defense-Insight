import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';

class GAppTheme {
  GAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'ReadexPro',
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFFFFF),
    secondaryHeaderColor: Color(0xFFF0F0F0),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    textTheme: GTextTheme.lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey.shade200,
      enabledBorder: OutlineInputBorder(
        // 👈 Blue outline when not focused
        borderSide: BorderSide(color: Appcolor.blue),
      ),
      focusedBorder: OutlineInputBorder(
        // 👈 Blue outline when focused
        borderSide: BorderSide(color: Appcolor.blue, width: 2.0),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'ReadexPro',
    brightness: Brightness.dark,
    primaryColor: Color(0xFFFFFFFF),
    secondaryHeaderColor: Color(0xFF1E1E1E),
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: GTextTheme.darkTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Appcolor.inputBlack,
      enabledBorder: OutlineInputBorder(
        // 👈 Blue outline when not focused
        borderSide: BorderSide(color: Appcolor.blue),
      ),
      focusedBorder: OutlineInputBorder(
        // 👈 Blue outline when focused
        borderSide: BorderSide(color: Appcolor.blue, width: 2.0),
      ),
    ),
  );
}
