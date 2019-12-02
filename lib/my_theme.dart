import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData _light = ThemeData.light();
  static ThemeData _dark = ThemeData.dark();

  static ThemeData light() {
    return ThemeData(
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
      )
    );
  }

  static ThemeData dark() {
    return _dark.copyWith();
  }
}
