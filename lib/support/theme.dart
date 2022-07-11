import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.backgroundColor,
      primarySwatch: Colors.orange,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.backgroundColor,
        foregroundColor: MyColors.darkTextColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: MyColors.darkTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: MyColors.backgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(MyColors.backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(color: Colors.orange, fontSize: 62, fontWeight: FontWeight.w200),
        headline4: TextStyle(color: MyColors.darkTextColor),
        headline5: TextStyle(color: MyColors.darkTextColor, fontSize: 16, fontWeight: FontWeight.w300),
        caption: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  static getDarkTheme() {
    return ThemeData();
  }
}

class MyColors {
  static Color? backgroundColor = Colors.grey[50];
  static Color? darkTextColor = Colors.grey[800];
}
