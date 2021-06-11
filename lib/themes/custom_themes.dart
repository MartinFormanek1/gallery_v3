import 'package:flutter/material.dart';
import 'package:gallery_v3/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme {
  static bool _isLight = false;
  static bool get getTheme => _isLight;

  static void changeTheme() async {
    _isLight = !_isLight;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightTheme', _isLight);
  }

  static set onInitApp(bool isLight) {
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

class CustomInputDecoration {
  static InputDecoration get authDecoration {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPallete.vermillion,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPallete.vermillion,
        ),
      ),
      errorStyle: TextStyle(
        fontSize: 10,
        color: Colors.red.shade900,
      ),
      hintText: 'if you see this text creator fucked up',
      hintStyle: TextStyle(
        color: CustomTheme.getTheme
            ? Colors.grey.shade700
            : ColorPallete.hintWhite,
      ),
    );
  }
}
