import 'package:flutter/material.dart';
import 'package:spotify_clone/theme/app_colors.dart';

import 'text_theme.dart';

class AppTheme {
  /// Thème sombre
  static final ThemeData darkTheme = ThemeData(
    fontFamily: "CircularStd",
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.bg,
      titleTextStyle: TextStyle(
        fontFamily: "CircularStd",
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 60,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(
        Colors.transparent,
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(color: AppColors.white, height: .8);
        }
        return const TextStyle(color: Colors.grey, height: .8);
      }),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.bg,
      onPrimary: AppColors.bg,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      extendedTextStyle: TextStyle(fontFamily: "CircularStd"),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          color: AppColors.primary,
          fontFamily: "CircularStd",
          fontSize: 14,
        ),
      ),
    ),
    textTheme: MyTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
