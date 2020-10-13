import 'package:facilapp/app/themes/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getDefaultTheme() {
    return ThemeData(
      primaryColor: GLColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline5: TextStyle(
          fontSize: 14,
          fontFamily: 'Gothan-Book',
          fontWeight: FontWeight.w700,
        ),
        headline4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'Gothan-Book',
          color: GLColors.primaryFontColor,
        ),
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: GLColors.primaryFontColor,
          fontFamily: 'Gothan-Book',
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontFamily: 'Gothan-Book',
        ),
        bodyText2: TextStyle(
          fontSize: 18,
          fontFamily: 'Gothan-Book',
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: GLColors.white,
        selectedItemColor: GLColors.primaryColor,
        unselectedItemColor: GLColors.primaryColor.withOpacity(.2),
        selectedIconTheme: IconThemeData(
          size: 26,
        ),
      ),
      iconTheme: IconThemeData(size: 24, color: GLColors.primaryIconColor),
      appBarTheme: AppBarTheme(
          color: GLColors.appBarBackgroudColor,
          textTheme: TextTheme(
            headline4: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gothan-Book',
                color: GLColors.primaryColor),
          ),
          iconTheme: IconThemeData(color: GLColors.primaryIconColor)),
      accentTextTheme: TextTheme(
        bodyText2: TextStyle(
          fontFamily: 'GothamMedium',
          color: GLColors.white,
        ),
      ),
    );
  }

  static ThemeData hamburguerMenuTheme() {
    return ThemeData(
      primaryColor: GLColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: GLColors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 18,
          fontFamily: 'Gothan-Book',
        ),
      ),
      dividerColor: GLColors.gray,
    );
  }

  static ThemeData profileCard() {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 16,
          fontFamily: 'Gothan-Book',
        ),
        bodyText2: TextStyle(
          fontSize: 18,
          fontFamily: 'Gothan-Book',
        ),
        headline4: TextStyle(
          fontFamily: 'Gothan-Book',
          fontSize: 16,
          color: GLColors.primaryColor,
        ),
        headline6: TextStyle(
          fontFamily: 'Gothan-Book',
          fontSize: 40,
        ),
      ),
    );
  }

  static ThemeData searchTextField() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
