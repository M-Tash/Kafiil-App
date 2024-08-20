import 'package:flutter/material.dart';

class MyTheme {
  static Color primary100Color = const Color(0xffEAFFF5);
  static Color primary900Color = const Color(0xff1DBF73);
  static Color bgGrey900Color = const Color(0xffFFFFFF);
  static Color grey50Color = const Color(0xffF9F9F9);
  static Color grey100Color = const Color(0xffF2F2F2);
  static Color grey200Color = const Color(0xffE6EAEF);
  static Color grey300Color = const Color(0xffC3C5C8);
  static Color grey400Color = const Color(0xff8692A6);
  static Color grey500Color = const Color(0xff696F79);
  static Color grey800Color = const Color(0xff333333);
  static Color grey900Color = const Color(0xff000000);
  static Color error300Color = const Color(0xffF56342);
  static Color error50Color = const Color(0xffFFF0ED);

  static ThemeData lightMode = ThemeData(
    dialogBackgroundColor: bgGrey900Color,
    colorScheme: ColorScheme.light(
      primary: primary900Color,
      onPrimary: bgGrey900Color,
      surface: bgGrey900Color,
      onSurface: grey900Color,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: primary900Color),
      backgroundColor: bgGrey900Color,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: grey900Color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      titleMedium: TextStyle(
        color: grey800Color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      titleSmall: TextStyle(
        color: grey500Color,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyLarge: TextStyle(
        color: grey900Color,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyMedium: TextStyle(
        color: grey500Color,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodySmall: TextStyle(
        color: primary900Color,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      displayLarge: TextStyle(
        color: grey300Color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
      displaySmall: TextStyle(
        color: primary900Color,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      displayMedium: TextStyle(
        color: error300Color,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
    ),
  );
}
