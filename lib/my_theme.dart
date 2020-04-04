import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static const white = Colors.white;
  static const grey = Color(0xff8F8F8F);
  static const black = Color(0xff212121);
  static const primary = Color(0xff2A93D5);
  static const secondary = Colors.orangeAccent;
  static const red = Colors.redAccent;
  static const orange = Colors.orangeAccent;
  static const accent = Colors.lightBlueAccent;

  static final italicStyle = TextStyle(
    color: grey,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal,
  );

  static final cardHeaderTextStyle = TextStyle(
    color: black,
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  );

  static const tenPadding = EdgeInsets.all(10.0);
  static final borderRadius = BorderRadius.circular(8.0);

  static ThemeData light() => ThemeData(
    fontFamily: 'Montserrat',
    primaryColor: primary,
    scaffoldBackgroundColor: white,
    accentColor: accent,
    hintColor: primary,
    errorColor: red,

    textTheme: TextTheme(
      body2: TextStyle(
        color: grey,
        fontWeight: FontWeight.normal
      ),

      subtitle: TextStyle(
        color: primary,
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
      ),
    ),

    appBarTheme: AppBarTheme(
      color: white,
      elevation: 1,
      iconTheme: IconThemeData(color: black),
      actionsIconTheme: IconThemeData(color: black),
      brightness: Brightness.light,
      textTheme: TextTheme(
        title: TextStyle(
          color: black,
          fontSize: 20.0,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      labelStyle: TextStyle(fontSize: 15.0),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: grey),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: grey),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: grey),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: grey),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: grey),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: red)
      ),
    ),

    cardTheme: CardTheme(
      elevation: 3.0,
      color: white,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(color: orange),
      ),
    )
  );
}
