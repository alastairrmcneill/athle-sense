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
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: MyColors.backgroundColor,
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
