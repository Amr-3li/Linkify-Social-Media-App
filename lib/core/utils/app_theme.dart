// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "PoppinsSemiBold",
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: MyColors.primaryColor,
      shadow: MyColors.shadowColor,
      onPrimaryContainer: MyColors.backgroundColor,
      onSurface: MyColors.fontColor,
      inverseSurface: const Color.fromARGB(255, 73, 73, 73),
      primary: MyColors.primaryColor,
      secondary: MyColors.buttonColor,
      onBackground: MyColors.backgroundColor,
      tertiary: const Color.fromARGB(255, 194, 194, 194),
      onTertiary: MyColors.fromMessage,
      onTertiaryContainer: MyColors.toMessageBorder,
      tertiaryContainer: MyColors.time,
    ),
    brightness: Brightness.light,
    primaryColor: MyColors.primaryColor,
    scaffoldBackgroundColor: MyColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.primaryColor,
      iconTheme: IconThemeData(color: MyColors.light),
      titleTextStyle: TextStyle(
        color: MyColors.fontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: MyColors.fontColor),
    ),
    iconTheme: const IconThemeData(
      color: MyColors.iconColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.buttonColor,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'PoppinsSemiBold',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: MyColors.darkPrimaryColor,
      shadow: MyColors.darkShadowColor,
      onPrimaryContainer: MyColors.darkBackgroundColor,
      onSurface: MyColors.darkFontColor,
      inverseSurface: MyColors.darkIconColor,
      primary: MyColors.darkPrimaryColor,
      secondary: MyColors.darkButtonColor,
      onBackground: MyColors.darkBackgroundColor,
      tertiary: MyColors.darkButtonSecondColor,
      onTertiary: MyColors.darkFromMessage,
      onTertiaryContainer: const Color.fromARGB(194, 0, 59, 72),
      tertiaryContainer: MyColors.time,
    ),
    brightness: Brightness.dark,
    primaryColor: MyColors.darkPrimaryColor,
    scaffoldBackgroundColor: MyColors.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.darkPrimaryColor,
      iconTheme: IconThemeData(color: MyColors.darkFontColor),
      titleTextStyle: TextStyle(
        color: MyColors.darkFontColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: MyColors.darkFontColor),
    ),
    iconTheme: const IconThemeData(color: MyColors.darkIconColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.darkButtonColor,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
