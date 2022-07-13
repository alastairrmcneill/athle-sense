import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.backgroundColor,
      primarySwatch: Colors.teal,
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
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MyColors.darkTextColor,
        contentTextStyle: TextStyle(color: MyColors.backgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(MyColors.backgroundColor),
          elevation: MaterialStateProperty.all<double?>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(color: Colors.orange, fontSize: 62, fontWeight: FontWeight.w200),
        headline2: TextStyle(color: MyColors.darkTextColor, fontSize: 60, fontWeight: FontWeight.w300),
        headline4: TextStyle(color: MyColors.darkTextColor, fontWeight: FontWeight.w300),
        headline5: TextStyle(color: MyColors.darkTextColor, fontSize: 16, fontWeight: FontWeight.w300),
        headline6: TextStyle(color: MyColors.darkTextColor, fontSize: 14, fontWeight: FontWeight.w300),
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

  static Color? lightBlueColor = const Color(0XFFe3effb);
  static Color? darkBlueColor = const Color(0XFF2b59e3);
  static Color? lightRedColor = const Color(0xFFfbceb9);
  static Color? darkRedColor = const Color(0xFFed6827);
  static Color? lightGreenColor = const Color(0xFFc1f1c7);
  static Color? darkGreenColor = const Color(0xFF68aa52);
  static Color? lightPurpleColor = const Color(0xFFe3e1f7);
  static Color? darkPurpleColor = const Color(0xFF7f73e1);
  static Color? lightYellowColor = const Color(0xFFf8ecc4);
  static Color? darkYellowColor = const Color(0xFFe2c430);
}
