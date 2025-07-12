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


  final themeLight = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.openSans,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
      },
    ),
    primaryTextTheme: TextTheme(
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary, // Background color for SnackBars
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
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white, // Text color for buttons
      iconColor: AppColors.chineseSilver,
        iconSize: size24// Icon color for buttons
      ),

    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.primary, // Icon color for icon buttons
        iconSize: size20,
        padding: EdgeInsets.zero,

        ),
    ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary, // Color for progress indicators
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      labelStyle: AppTextStyles.textField,
      prefixIconColor: AppColors.primaryLight,
      border: OutlineInputBorder(
        borderRadius: radius24,
        borderSide: BorderSide(color: AppColors.blueishGrey),
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
