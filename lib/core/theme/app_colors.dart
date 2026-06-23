import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary Palette ──────────────────────────────────────────────────────────
  static const primary = Color(0xFF0D47A1);
  static const primarySurface = Color(0xFF1565C0);
  static const primaryLight = Color(0xFF1976D2);
  static const pageBackground = Color(0xFFF0F4FF);
  static const cardSurface = Color(0xFFFFFFFF);

  /// Mint green — used ONLY on the Run button. Semantic signal: execute.
  static const runButton = Color(0xFF69F0AE);
  static const runButtonText = Color(0xFF004D40);

  /// Code editor dark surface — warmer than pure black.
  static const codeEditorSurface = Color(0xFF1A1F2E);
  static const codeEditorHeader = Color(0xFF151924);
  static const codeEditorBorder = Color(0xFF2D3748);
  static const codeEditorLineNumbers = Color(0xFF4A5568);

  // ── Dark Mode ────────────────────────────────────────────────────────────────
  static const darkBackground = Color(0xFF0A0E1A);
  static const darkCard = Color(0xFF111827);
  static const darkBorder = Color(0xFF1F2937);
  static const darkPrimary = Color(0xFF90CAF9);
  static const darkTextPrimary = Color(0xFFF1F5F9);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkBottomNav = Color(0xFF0E1424);

  // ── Difficulty ───────────────────────────────────────────────────────────────
  static const beginner = Color(0xFF4CAF50);
  static const intermediate = Color(0xFFFFC107);
  static const advanced = Color(0xFFF44336);

  // ── Category Accent Colors ───────────────────────────────────────────────────
  static const basicCategory = Color(0xFF4CAF50);      // Green
  static const materialCategory = Color(0xFF2196F3);   // Blue
  static const inputCategory = Color(0xFFFF9800);      // Orange
  static const listCategory = Color(0xFF9C27B0);       // Purple
  static const navCategory = Color(0xFF00BCD4);        // Cyan
  static const animCategory = Color(0xFFFF5722);       // Deep Orange
  static const stateCategory = Color(0xFF607D8B);      // Blue Grey
  static const cupertinoCategory = Color(0xFF3F51B5);  // Indigo
  static const advancedCategory = Color(0xFFE91E63);   // Pink

  // ── Code Syntax Highlighting ─────────────────────────────────────────────────
  static const codeKeyword = Color(0xFFBB86FC);   // purple: const, final, class
  static const codeClass = Color(0xFF69F0AE);     // mint: type names
  static const codeString = Color(0xFFFFB74D);    // amber: string literals
  static const codeNumber = Color(0xFF80DEEA);    // cyan: numeric literals
  static const codeBase = Color(0xFFCFD8DC);      // light grey: base code
  static const codeComment = Color(0xFF546E7A);   // muted: comments

  // ── Tip / Info Card ──────────────────────────────────────────────────────────
  static const tipBorder = Color(0xFFFFC107);
  static const tipBackground = Color(0xFFFFFBF0);
}