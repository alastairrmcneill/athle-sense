import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.backgroundColor,
      primarySwatch: Colors.cyan,
    );
  }

  static getDarkTheme() {
    return ThemeData();
  }
}

class MyColors {
  static Color? backgroundColor = Colors.grey[200];
}
