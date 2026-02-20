import 'package:flutter/material.dart';
import 'package:my_notes_app/core/constants/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes_app/core/constants/theme/app_font_weight.dart';

class AppTextStyle {
  // ==== HEADLINE ====
  static TextStyle headline = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle title = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.black,
  );

  // ==== BODY ====
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: AppColors.black,
  );

  static TextStyle small = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.grey,
  );

  // ==== BUTTON ====
  static TextStyle button = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
    color: AppColors.white,
  );
}
