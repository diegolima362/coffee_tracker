import 'package:flutter/material.dart';

class CustomThemes {
  CustomThemes._();

  static ThemeData get light {
    final white = Color(0xFFFEFEFE);

    // final otherWhite = Color(0xFFFEFEFE);
    // final red = Color(0xFFE63946);
    final textColor = Color(0xFF1D3557);
    final accent = Color(0xFF1D3557);
    final primary = Color(0xFF457B9D);
    final disableIcon = Color(0xFFDDDDDD);
    final selectedColor = Color(0xFF1D3557);
    final cardColor = Color(0xFFFFFFFF);
    final buttonColor = Color(0xFF274C77);
    final iconColor = Color(0xFF1D3557);
    final dividerColor = Color(0xFFDDDDDD);
    final anotherWhite = Color(0xFFAAAAAA);

    return ThemeData(
      brightness: Brightness.light,
      accentColorBrightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      indicatorColor: textColor,
      backgroundColor: white,
      primaryColor: primary,
      buttonTheme: ButtonThemeData(
        buttonColor: buttonColor,
        textTheme: ButtonTextTheme.primary,
      ),
      accentColor: accent,
      canvasColor: white,
      disabledColor: disableIcon,
      iconTheme: IconThemeData(color: iconColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: white,
        unselectedIconTheme: IconThemeData(color: disableIcon),
        selectedIconTheme: IconThemeData(color: selectedColor),
      ),
      cardTheme: CardTheme(color: cardColor),
      dividerColor: dividerColor,
      textTheme: TextTheme(
        button: TextStyle(
          color: white,
        ),
        subtitle2: TextStyle(
          color: anotherWhite,
        ),
        subtitle1: TextStyle(
          color: textColor,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: textColor,
        foregroundColor: white,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: textColor),
        actionsIconTheme: IconThemeData(color: textColor),
        color: white,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            color: textColor,
          ),
        ),
        elevation: 0,
      ),
    );
  }

  static ThemeData get dark {
    final white = Color(0xFFFEFEFE);
    final dark = Color(0xFF121212);
    // final otherWhite = Color(0xFFFEFEFE);
    // final red = Color(0xFFE63946);
    final textColor = Color(0xFFEEEEEE);
    final accent = Color(0xFFE43F5A);
    final primary = Color(0xFFE43F5A);
    final disableIcon = Color(0xFFDDDDDD);
    final selectedColor = Color(0xFFE43F5A);
    final cardColor = Color(0xFF252525);
    final buttonColor = Color(0xFFE43F5A);
    final iconColor = Color(0xFFE43F5A);
    final dividerColor = Color(0xFF121212);
    final anotherWhite = Color(0xFFAAAAAA);

    return ThemeData(
      brightness: Brightness.dark,
      accentColorBrightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      indicatorColor: textColor,
      toggleableActiveColor: accent,
      backgroundColor: dark,
      primaryColor: primary,
      buttonTheme: ButtonThemeData(
        buttonColor: buttonColor,
        textTheme: ButtonTextTheme.primary,
      ),
      accentColor: accent,
      canvasColor: dark,
      disabledColor: disableIcon,
      iconTheme: IconThemeData(color: iconColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: dark,
        unselectedIconTheme: IconThemeData(color: disableIcon),
        selectedIconTheme: IconThemeData(color: selectedColor),
      ),
      cardTheme: CardTheme(color: cardColor),
      dividerColor: dividerColor,
      textTheme: TextTheme(
        button: TextStyle(
          color: white,
        ),
        subtitle2: TextStyle(
          color: anotherWhite,
        ),
        subtitle1: TextStyle(
          color: textColor,
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: iconColor,
        foregroundColor: dark,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: textColor),
        actionsIconTheme: IconThemeData(color: textColor),
        color: dark,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            color: textColor,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
