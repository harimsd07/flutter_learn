import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          primaryContainer: Color(0xFFD6E4FF),
          onPrimaryContainer: AppColors.primary,
          secondary: AppColors.primaryLight,
          onSecondary: Colors.white,
          secondaryContainer: Color(0xFFE3EFFF),
          onSecondaryContainer: AppColors.primarySurface,
          surface: AppColors.cardSurface,
          onSurface: Color(0xFF1A1A2E),
          surfaceContainerHighest: Color(0xFFEEF2FF),
          onSurfaceVariant: Color(0xFF5C6278),
          outline: Color(0xFFDDE3F0),
          error: Color(0xFFF44336),
          onError: Colors.white,
          errorContainer: Color(0xFFFFEDED),
          onErrorContainer: Color(0xFFC62828),
          shadow: Colors.black,
          scrim: Colors.black,
          inverseSurface: Color(0xFF111827),
          onInverseSurface: Color(0xFFF1F5F9),
          inversePrimary: AppColors.darkPrimary,
        ),
        scaffoldBackgroundColor: AppColors.pageBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 2,
          centerTitle: false,
          titleTextStyle: AppTextStyles.subheading,
          iconTheme: const IconThemeData(color: Colors.white, size: 22),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0x12000000)),
          ),
          shadowColor: Colors.black.withValues(alpha: 0.05),
          margin: EdgeInsets.zero,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.cardSurface,
          indicatorColor: AppColors.primary.withValues(alpha: 0.12),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.primary, size: 22);
            }
            return const IconThemeData(color: Color(0xFF94A3B8), size: 22);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.inter(
                  fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary);
            }
            return GoogleFonts.inter(
                fontSize: 11, fontWeight: FontWeight.w400, color: const Color(0xFF94A3B8));
          }),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black.withValues(alpha: 0.08),
        ),
        textTheme: GoogleFonts.interTextTheme().copyWith(
          displayLarge: AppTextStyles.displayLarge(),
          titleLarge: AppTextStyles.titleLarge(),
          titleMedium: AppTextStyles.titleMedium(),
          bodyMedium: AppTextStyles.bodyMedium(),
          bodySmall: AppTextStyles.bodySmall(),
          labelSmall: AppTextStyles.labelSmall(),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: const BorderSide(color: Color(0xFFDDE3F0)),
          backgroundColor: Colors.white,
          labelStyle: AppTextStyles.labelSmall(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.runButton,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
          dividerColor: Colors.transparent,
          labelStyle: AppTextStyles.labelSmall(color: Colors.white),
          unselectedLabelStyle: AppTextStyles.labelSmall(),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFEEF2FF),
          thickness: 1,
          space: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.darkPrimary,
          onPrimary: Color(0xFF0A0E1A),
          primaryContainer: Color(0xFF1A2744),
          onPrimaryContainer: AppColors.darkPrimary,
          secondary: Color(0xFF64B5F6),
          onSecondary: Color(0xFF0A0E1A),
          secondaryContainer: Color(0xFF162033),
          onSecondaryContainer: Color(0xFF90CAF9),
          surface: AppColors.darkCard,
          onSurface: AppColors.darkTextPrimary,
          surfaceContainerHighest: Color(0xFF1A2035),
          onSurfaceVariant: AppColors.darkTextSecondary,
          outline: AppColors.darkBorder,
          error: Color(0xFFCF6679),
          onError: Color(0xFF1A0010),
          errorContainer: Color(0xFF3B1015),
          onErrorContainer: Color(0xFFFFB3B8),
          shadow: Colors.black,
          scrim: Colors.black,
          inverseSurface: Color(0xFFF1F5F9),
          onInverseSurface: Color(0xFF111827),
          inversePrimary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: false,
          titleTextStyle: AppTextStyles.subheading.copyWith(color: AppColors.darkTextPrimary),
          iconTheme: const IconThemeData(color: AppColors.darkTextPrimary, size: 22),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.darkBorder),
          ),
          margin: EdgeInsets.zero,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.darkBottomNav,
          indicatorColor: AppColors.darkPrimary.withValues(alpha: 0.15),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.darkPrimary, size: 22);
            }
            return const IconThemeData(color: AppColors.darkTextSecondary, size: 22);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.inter(
                  fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.darkPrimary);
            }
            return GoogleFonts.inter(
                fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.darkTextSecondary);
          }),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: AppTextStyles.displayLarge(color: AppColors.darkTextPrimary),
          titleLarge: AppTextStyles.titleLarge(color: AppColors.darkTextPrimary),
          titleMedium: AppTextStyles.titleMedium(color: AppColors.darkTextPrimary),
          bodyMedium: AppTextStyles.bodyMedium(color: AppColors.darkTextSecondary),
          bodySmall: AppTextStyles.bodySmall(color: AppColors.darkTextSecondary),
          labelSmall: AppTextStyles.labelSmall(color: AppColors.darkTextSecondary),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: const BorderSide(color: AppColors.darkBorder),
          backgroundColor: AppColors.darkCard,
          labelStyle: AppTextStyles.labelSmall(color: AppColors.darkTextSecondary),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
        tabBarTheme: TabBarThemeData(
          indicatorColor: AppColors.runButton,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.darkTextPrimary,
          unselectedLabelColor: AppColors.darkTextSecondary,
          dividerColor: Colors.transparent,
          labelStyle: AppTextStyles.labelSmall(color: AppColors.darkTextPrimary),
          unselectedLabelStyle: AppTextStyles.labelSmall(color: AppColors.darkTextSecondary),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.darkBorder,
          thickness: 1,
          space: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
}