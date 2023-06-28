import 'package:flutter/material.dart';
import 'package:productivityapp/presentation/ui/resources/app_colors.dart';

class AppTheme {
  static TextTheme darkThemeText = TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      fontFamily: 'MainFont',
    ),
    bodySmall: TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      fontFamily: 'MainFont',
    ),
    titleMedium: TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: 'MainFont',
    ),
    titleLarge: TextStyle(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      fontFamily: 'MainFont',
    ),
  );
  static ThemeData dark() => ThemeData(
        fontFamily: 'MainFont',
        textTheme: darkThemeText,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          foregroundColor: AppColors.textWhite,
          backgroundColor: AppColors.darkPurple,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: AppColors.textGray,
          selectedItemColor: AppColors.textWhite,
          backgroundColor: AppColors.darkPurple,
        ),
      );
}
