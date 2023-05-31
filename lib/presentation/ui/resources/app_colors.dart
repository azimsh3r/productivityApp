import 'package:flutter/material.dart';

abstract class AppColors {
  // Text
  static Color textWhite = const Color(0xFFFFFFFF);
  static Color textGray = const Color(0xFF777E99);
  static Color textDarkGray = const Color(0xFF535252);
  // Button, ProgressIndicator, Calendar
  static Color purple = const Color(0xFF7A12FF);
  // BottomNavBar, AppBar
  static Color darkPurple = const Color(0xFF242443);
  static Color lightPurple = const Color(0xFF7454F8);
  static Color enabledPurple = const Color(0xFF7A12FF);
  // background Color
  static Color backgroundColor = const Color(0xFF1A1A2F);

  // Expansion Tick Colors
  static List<Color> tickColors = const [
    Color(0xFFF6B707),
    Color(0xFF34B467),
    Color(0xFFC082FD),
  ];
}
