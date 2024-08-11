import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightMode = ThemeData(
      colorScheme: ColorScheme.light(
          surface: Colors.grey.shade300,
          //const Color(0xffDCDCDC),
          primary: Colors.white,
          //grey.shade500
          secondary: Colors.grey.shade200,
          tertiary: Colors.white,
          inversePrimary: Colors.grey.shade900));

  static ThemeData darkMode = ThemeData(
      colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          //const Color(0xff171719),
          primary: const Color(0xff25262d),
          // grey.shade600
          secondary: const Color.fromARGB(255, 44, 44, 44),
          tertiary: Colors.grey.shade800,
          inversePrimary: Colors.grey.shade300));
}
