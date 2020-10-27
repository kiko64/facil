import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getDefaultTheme() {
    return ThemeData(
      primaryColor: OcoboColors.primaryColor,
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
          color: OcoboColors.primaryFontColor,
        ),
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: OcoboColors.primaryFontColor,
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
        backgroundColor: OcoboColors.white,
        selectedItemColor: OcoboColors.primaryColor,
        unselectedItemColor: OcoboColors.primaryColor.withOpacity(.2),
        selectedIconTheme: IconThemeData(
          size: 26,
        ),
      ),
      iconTheme: IconThemeData(size: 24, color: OcoboColors.primaryIconColor),
      appBarTheme: AppBarTheme(
          color: OcoboColors.appBarBackgroudColor,
          textTheme: TextTheme(
            headline4: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gothan-Book',
                color: OcoboColors.primaryColor),
          ),
          iconTheme: IconThemeData(color: OcoboColors.primaryIconColor)),
      accentTextTheme: TextTheme(
        bodyText2: TextStyle(
          fontFamily: 'GothamMedium',
          color: OcoboColors.white,
        ),
      ),
    );
  }

  static ThemeData hamburguerMenuTheme() {
    return ThemeData(
      primaryColor: OcoboColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: OcoboColors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 18,
          fontFamily: 'Gothan-Book',
        ),
      ),
      dividerColor: OcoboColors.gray,
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
          color: OcoboColors.primaryColor,
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
