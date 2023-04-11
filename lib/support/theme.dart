import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.darkBackgroundColor,
      dialogBackgroundColor: MyColors.darkBackgroundColor,
      primarySwatch: Colors.blue,
      canvasColor: Color.fromRGBO(75, 135, 185, 1), // line color for charts - possible MyColors.accentColor,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.darkBackgroundColor,
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
        backgroundColor: MyColors.darkBackgroundColor,
        selectedItemColor: MyColors.darkAccentColor,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyColors.darkAccentColor,
        foregroundColor: MyColors.darkBackgroundColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(MyColors.darkAccentColor),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MyColors.lightTextColor,
        contentTextStyle: TextStyle(color: MyColors.darkBackgroundColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(MyColors.darkAccentColor),
          foregroundColor: MaterialStateProperty.all<Color?>(MyColors.darkBackgroundColor),
          elevation: MaterialStateProperty.all<double?>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: MyColors.darkAccentColor),
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
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyColors.lightTextColor!),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: MyColors.darkAccentColor, fontSize: 62, fontWeight: FontWeight.w200),
        headline2: TextStyle(color: MyColors.lightTextColor, fontSize: 60, fontWeight: FontWeight.w300),
        headline4: TextStyle(color: MyColors.lightTextColor, fontWeight: FontWeight.w300),
        headline5: TextStyle(color: MyColors.lightTextColor, fontSize: 18, fontWeight: FontWeight.w200),
        headline6: TextStyle(color: MyColors.lightTextColor, fontSize: 14, fontWeight: FontWeight.w200),
        caption: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
      ),
      unselectedWidgetColor: Colors.grey[350],
      drawerTheme: DrawerThemeData(
        backgroundColor: MyColors.darkBackgroundColor,
      ),
      dividerColor: MyColors.lightTextColor!.withOpacity(0.8),
      cardColor: MyColors.darkCardColor,
      cardTheme: CardTheme(
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: MyColors.lightBackgroundColor,
        textStyle: TextStyle(
          color: MyColors.darkBackgroundColor,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: MyColors.darkCardColor,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: MyColors.lightBackgroundColor,
        dialogBackgroundColor: MyColors.lightBackgroundColor,
        primarySwatch: Colors.orange,
        canvasColor: Color.fromRGBO(75, 135, 185, 1), // line color for charts - possible MyColors.accentColor,
        appBarTheme: AppBarTheme(
          backgroundColor: MyColors.lightBackgroundColor,
          foregroundColor: MyColors.darkTextColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: MyColors.darkTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyColors.lightBackgroundColor,
          elevation: 0,
          unselectedItemColor: Color.fromARGB(255, 167, 167, 184),
          selectedItemColor: MyColors.lightAccentColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: MyColors.lightAccentColor,
          foregroundColor: MyColors.lightBackgroundColor,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: MyColors.darkBackgroundColor,
          contentTextStyle: TextStyle(color: MyColors.lightTextColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(MyColors.lightAccentColor),
            foregroundColor: MaterialStateProperty.all<Color?>(MyColors.darkTextColor),
            elevation: MaterialStateProperty.all<double?>(3),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color?>(MyColors.lightAccentColor),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: MyColors.darkTextColor,
          suffixIconColor: MyColors.darkTextColor,
          labelStyle: TextStyle(
            color: MyColors.darkTextColor,
          ),
          hintStyle: TextStyle(color: MyColors.darkTextColor!.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w200),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.darkTextColor!),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColors.darkTextColor!),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: MyColors.lightAccentColor),
        textTheme: TextTheme(
          headline1: TextStyle(color: MyColors.lightAccentColor!, fontSize: 62, fontWeight: FontWeight.w200),
          headline2: TextStyle(color: MyColors.darkTextColor, fontSize: 60, fontWeight: FontWeight.w300),
          headline4: TextStyle(color: MyColors.darkTextColor, fontWeight: FontWeight.w300),
          headline5: TextStyle(color: MyColors.darkTextColor, fontSize: 18, fontWeight: FontWeight.w200),
          headline6: TextStyle(color: MyColors.darkTextColor, fontSize: 14, fontWeight: FontWeight.w200),
          caption: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        unselectedWidgetColor: Colors.grey[350],
        drawerTheme: DrawerThemeData(
          backgroundColor: MyColors.lightBackgroundColor,
        ),
        dividerColor: MyColors.darkTextColor!.withOpacity(0.8),
        cardColor: Color(0xFFFFFFFF),
        cardTheme: CardTheme(
          elevation: 3,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: MyColors.lightBackgroundColor,
          textStyle: TextStyle(
            color: MyColors.darkTextColor,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFFFFFFFF)));
  }
}

class MyColors {
  static Color? darkTextColor = const Color(0xFF005D72);
  static Color? lightTextColor = Colors.grey[50];
  static Color? darkBackgroundColor = const Color(0xFF323641);
  static Color? lightBackgroundColor = const Color(0xFFF4F5FA);

  static Color? darkCardColor = const Color(0xFF404552);

  static Color? lightAccentColor = const Color(0xFFFF8A65);
  static Color? darkAccentColor = Color.fromARGB(255, 101, 255, 181);

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
