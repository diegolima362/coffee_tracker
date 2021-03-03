import 'package:flutter/material.dart';

class CustomThemes {
  static ThemeData get dark {
    final accent = const Color(0xffbdbdbd);

    return ThemeData.dark().copyWith(
      accentColor: accent,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
      ),
      canvasColor: const Color(0xff181818),
      backgroundColor: const Color(0xff181818),
      cardColor: const Color(0xff1d1d1d),
      cardTheme: const CardTheme(
        color: const Color(0xff1d1d1d),
      ),
      appBarTheme: const AppBarTheme(
        color: const Color(0xff202020),
        brightness: Brightness.dark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff202020),
      ),
    );
  }

  static ThemeData get light {
    return ThemeData.light().copyWith(
      primaryColor: const Color(0xff344955),
      accentColor: const Color(0xff4a6572),
      canvasColor: const Color(0xfffafafa),
      backgroundColor: const Color(0xfffafafa),
      cardColor: const Color(0xffffffff),
      appBarTheme: const AppBarTheme(
        color: const Color(0xffffffff),
        elevation: 1.0,
        brightness: Brightness.light,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: const Color(0xfff9aa33),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff344955),
        unselectedIconTheme: IconThemeData(
          color: const Color(0xffdddddd),
        ),
        selectedIconTheme: const IconThemeData(
          color: const Color(0xffffffff),
        ),
      ),
    );
  }
}
