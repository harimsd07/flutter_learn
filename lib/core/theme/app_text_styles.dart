import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design brief type scale:
/// Display/App name  → DM Sans 600–700
/// Body / UI text    → Inter 400–500
/// Code editor       → JetBrains Mono 400
/// Badges/labels     → Inter 600
class AppTextStyles {
  AppTextStyles._();

  static TextStyle displayLarge({Color? color}) => GoogleFonts.dmSans(
        fontSize: 24, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleLarge({Color? color}) => GoogleFonts.dmSans(
        fontSize: 18, fontWeight: FontWeight.w600, color: color);

  static TextStyle titleMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 15, fontWeight: FontWeight.w500, color: color);

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: color, height: 1.5);

  static TextStyle bodySmall({Color? color}) => GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w400, color: color);

  static TextStyle labelSmall({Color? color}) => GoogleFonts.inter(
        fontSize: 10, fontWeight: FontWeight.w600,
        letterSpacing: 0.3, color: color);

  static TextStyle code({Color? color}) => GoogleFonts.jetBrainsMono(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        height: 1.7,
        color: color);

  // ── Legacy static accessors for AppBarTheme ──────────────────────────────────
  static TextStyle get heading => GoogleFonts.dmSans(
      fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle get subheading => GoogleFonts.dmSans(
      fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle get button => GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w600);
}