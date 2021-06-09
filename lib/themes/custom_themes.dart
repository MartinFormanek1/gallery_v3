import 'package:flutter/material.dart';
import 'package:gallery_v3/shared/colors.dart';

class CustomTheme {
  static bool _isLight = false;
  static bool get getTheme => _isLight;
  static void set isThemeLight(bool isLight) {
    _isLight = isLight;
  }

  static ThemeData get currentTheme {
    return getTheme ? lightTheme : darkTheme;
  }

  static ThemeData get reverseThemeColor {
    return getTheme ? darkTheme : lightTheme;
  }

  static Color get reverseTextColor {
    return getTheme ? Colors.black : ColorPallete.fullWhite;
  }

  static ThemeData get lightTheme {
    return ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorPallete.vermillion,
        ),
        scaffoldBackgroundColor: ColorPallete.fullWhite,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: ColorPallete.fullWhite,
          displayColor: ColorPallete.fullWhite,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorPallete.vermillion,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorPallete.vermillion,
        ),
        scaffoldBackgroundColor: ColorPallete.backgroundBlack,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: ColorPallete.fullWhite,
          displayColor: ColorPallete.fullWhite,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorPallete.vermillion,
        ));
  }
}
