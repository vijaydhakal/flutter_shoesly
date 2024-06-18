import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xffE5E5E5);
  static const double symmetricHozPadding = 13.0;
  static const Color lightGray = Color(0xFF707070);
  static const Color darkGray = Color(0xFF3E3E3E);
  static const Color bgDark = Color(0xff15181C);
  static const Color textColor = Color(0xFF101010);

  static const Color blue = Color(0xFF031950);
  static const Color yellow = Color(0xFFEBBD31);
  static const Color lightBlue = Color(0xFFC8CFEA);
  static const Color green = Color(0xFF2C8E05);
  static const Color black = Color(0xFF272727);
  static const Color errorColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Color(0xffE5E5E5),
    primaryColorDark: Color(0xffE5E5E5),
    shadowColor: Colors.black,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
      color: Color(0xffE5E5E5),
    )),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff707070)),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      displayMedium: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
        color: textColor,
      ),
      titleLarge: TextStyle(
        color: textColor,
      ),
      bodySmall: TextStyle(
        color: textColor,
      ),
      labelLarge: TextStyle(
        color: textColor,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
  );
}
