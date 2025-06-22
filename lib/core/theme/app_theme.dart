import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_quotes/core/theme/app_fonts.dart';
import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

class AppTheme {
  static const String light = 'light';
  static const String dark = 'dark';
  static const String system = 'system';
  static const List<String> themes = [light, dark, system];

  static String getDefaultTheme() {
    return system; // Default to system theme
  }

  final theme = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.openSans,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightCrimson),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      },
    ),
    primaryTextTheme: TextTheme(
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightCrimson, // Background color for SnackBars
      contentTextStyle: AppTextStyles.body, // Text style for SnackBars
      actionTextColor: Colors.white, // Action text color for SnackBars
    ),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // Primary color for buttons
        shape: RoundedRectangleBorder(
          // Using a light blue color for buttons
          borderRadius: radius24, // Using the radius from app_sizes.dart
        ),
        backgroundColor: AppColors.lightCrimson,
        foregroundColor: Colors.white, // Text color for buttons
      iconColor: AppColors.chineseSilver,
        iconSize: size24// Icon color for buttons
      ),

    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.lightCrimson, // Icon color for icon buttons
        iconSize: size20,
        padding: EdgeInsets.zero,

        ),
    ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.lightCrimson, // Color for progress indicators
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      labelStyle: AppTextStyles.textField,
      prefixIconColor: AppColors.chineseSilver,
      border: OutlineInputBorder(
        borderRadius: radius24,
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius24,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius24,
        borderSide: BorderSide.none,
      ),
    ),
  );
}
