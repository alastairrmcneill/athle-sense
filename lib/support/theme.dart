import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.backgroundColor,
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.backgroundColor,
        foregroundColor: MyColors.lightTextColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: MyColors.lightTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: MyColors.backgroundColor,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MyColors.lightTextColor,
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
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: MyColors.lightTextColor,
        suffixIconColor: MyColors.lightTextColor,
        labelStyle: TextStyle(
          color: MyColors.lightTextColor,
        ),
        hintStyle: TextStyle(color: MyColors.lightTextColor!.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w200),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.lightTextColor!),
        ),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(color: Colors.orange, fontSize: 62, fontWeight: FontWeight.w200),
        headline2: TextStyle(color: MyColors.lightTextColor, fontSize: 60, fontWeight: FontWeight.w300),
        headline4: TextStyle(color: MyColors.lightTextColor, fontWeight: FontWeight.w300),
        headline5: TextStyle(color: MyColors.lightTextColor, fontSize: 18, fontWeight: FontWeight.w200),
        headline6: TextStyle(color: MyColors.lightTextColor, fontSize: 14, fontWeight: FontWeight.w200),
        caption: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      unselectedWidgetColor: Colors.grey[350],
    );
  }

  static getDarkTheme() {
    return ThemeData();
  }
}

class MyColors {
  static Color? lightTextColor = Colors.grey[50];
  static Color? backgroundColor = const Color(0xFF323641);
  static Color? cardColor = const Color(0xFF404552);

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

List<Color> myCalendarColors = [
  Color.fromRGBO(230, 0, 70, 1),
  Color.fromRGBO(230, 5, 70, 1),
  Color.fromRGBO(230, 30, 70, 1),
  Color.fromRGBO(230, 55, 70, 1),
  Color.fromRGBO(230, 80, 70, 1),
  Color.fromRGBO(230, 105, 70, 1),
  Color.fromRGBO(230, 130, 70, 1),
  Color.fromRGBO(230, 155, 70, 1),
  Color.fromRGBO(230, 180, 70, 1),
  Color.fromRGBO(230, 205, 70, 1),
  Color.fromRGBO(240, 240, 70, 1),
  Color.fromRGBO(205, 230, 70, 1),
  Color.fromRGBO(180, 230, 70, 1),
  Color.fromRGBO(155, 230, 70, 1),
  Color.fromRGBO(130, 230, 70, 1),
  Color.fromRGBO(105, 230, 70, 1),
  Color.fromRGBO(80, 230, 70, 1),
  Color.fromRGBO(55, 230, 70, 1),
  Color.fromRGBO(30, 230, 70, 1),
  Color.fromRGBO(5, 230, 70, 1),
  Color.fromRGBO(0, 230, 70, 1),
];

List<Color> ratingColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Color.fromARGB(255, 149, 195, 74),
  Color.fromARGB(255, 29, 186, 34),
];
