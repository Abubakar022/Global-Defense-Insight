import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';

class GTextTheme {
  GTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Appcolor.lightFontColor,
    ),
    headlineMedium: TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        overflow: TextOverflow.ellipsis),
    headlineSmall: TextStyle().copyWith(
        fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
    titleSmall: TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w600, color: Appcolor.blue),
         titleMedium: TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  );



  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Appcolor.darkFontColor),
    headlineMedium: TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        overflow: TextOverflow.ellipsis),
    headlineSmall: TextStyle().copyWith(
        fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
    titleSmall: TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w600, color: Appcolor.blue),
        
        titleMedium: TextStyle().copyWith(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  );
}
