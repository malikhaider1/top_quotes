import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/painting.dart';

import 'app_colors.dart';
class AppTextStyles {

  static TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.raisinBlack, // Raisin Black color
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static  TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static  TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle textField = TextStyle(
    fontSize: 15,
    color: AppColors.chineseSilver, // Chinese Silver color
  );
}