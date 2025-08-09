import 'dart:ui';

import 'package:flutter/material.dart';

abstract class MyColors {
  // Light Theme Colors
  static const Color backgroundColor = Colors.white;
  static const Color shadowColor = Color(0xFFE0E0E0);
  static const Color fontColor = Colors.black;
  static const Color primaryColor = Color(0xFF6CD4C4);
  static const Color buttonColor = Color(0xFF009688);

  static const Color iconColor = Color.fromARGB(255, 174, 174, 174);
  static const Color iconNavColor = Color(0xFFEAEAEA);
  static const Color iconActiveColor = Color(0xFF4A6FA5);
  static const Color textColor = Color(0xFFE0E0E0);
  static const Color buttonSecondColor = Color(0xFFE0E0E0);

  static const Color light = Color(0xFFFFFFFF);
  static const Color mainChat = Color.fromARGB(194, 135, 189, 183);
  static const Color toMessageBorder = Color.fromARGB(194, 9, 103, 124);
  static const Color fromMessage = Color.fromARGB(194, 230, 231, 231);
  static const Color fromMessageBorder = Color.fromARGB(194, 122, 122, 122);

  static const Color time = Color.fromARGB(255, 157, 157, 157);

  // Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkShadowColor = Color(0xFF1E1E1E);
  static const Color darkFontColor = Colors.white;
  static const Color darkPrimaryColor = Color(0xFF6CD4C4); // فاتح على الأسود
  static const Color darkButtonColor = Color(0xFF009688);
  static const Color darkIconColor = Color(0xFFB0B0B0);
  static const Color darkIconNavColor = Color(0xFF1E1E1E);
  static const Color darkIconActiveColor = Color(0xFF6CD4C4);
  static const Color darkTextColor = Color(0xFFB0B0B0);
  static const Color darkButtonSecondColor = Color(0xFF2C2C2C);
  static const Color darkLight = Color(0xFF1E1E1E);
  static const Color darkMainChat = Color(0xFF6CD4C4);
  static const Color darkToMessageBorder = Color(0xFF6CD4C4);
  static const Color darkFromMessage = Color(0xFF2C2C2C);
  static const Color darkFromMessageBorder = Color(0xFF3A3A3A);
  static const Color darkTime = Color(0xFF888888);
}
