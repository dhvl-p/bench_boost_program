import 'package:flutter/material.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_colors.dart';

/// Centralised theme definitions for the Responsive Portfolio UI.
///
/// Usage:
///   Theme(data: PortfolioTheme.dark, child: …)
///   Theme(data: PortfolioTheme.of(isDark), child: …)
class PortfolioTheme {
  PortfolioTheme._(); // prevent instantiation

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Returns the dark [ThemeData].
  static ThemeData get dark => _buildDark();

  /// Returns the light [ThemeData].
  static ThemeData get light => _buildLight();

  /// Convenience method — picks dark or light based on [isDark].
  static ThemeData of(bool isDark) => isDark ? _buildDark() : _buildLight();

  // ── Dark Theme ─────────────────────────────────────────────────────────────
  static ThemeData _buildDark() {
    return ThemeData.dark().copyWith(
      // Scaffold
      scaffoldBackgroundColor: PortfolioColors.bgDark,

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: PortfolioColors.accent,
        secondary: PortfolioColors.accent,
        surface: PortfolioColors.bgCardDark,
        onPrimary: Colors.black,
        onSurface: PortfolioColors.textPrimaryDark,
      ),

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: PortfolioColors.bgDark,
        foregroundColor: PortfolioColors.textPrimaryDark,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      // Card
      cardTheme: CardThemeData(
        color: PortfolioColors.bgCardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: PortfolioColors.dividerDark),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: PortfolioColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: PortfolioColors.textSecondaryDark,
        size: 20,
      ),

      // Text
      textTheme: _buildTextTheme(
        primary: PortfolioColors.textPrimaryDark,
        secondary: PortfolioColors.textSecondaryDark,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PortfolioColors.bgCardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.accent, width: 1.5),
        ),
        hintStyle: const TextStyle(color: PortfolioColors.textSecondaryDark),
        labelStyle: const TextStyle(color: PortfolioColors.textSecondaryDark),
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PortfolioColors.accent,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PortfolioColors.textPrimaryDark,
          side: const BorderSide(color: PortfolioColors.dividerDark),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PortfolioColors.accent,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      // Progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: PortfolioColors.accent,
        linearTrackColor: PortfolioColors.bgCardDark,
      ),

      // List tile
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: PortfolioColors.textPrimaryDark,
        iconColor: PortfolioColors.textSecondaryDark,
      ),
    );
  }

  // ── Light Theme ────────────────────────────────────────────────────────────
  static ThemeData _buildLight() {
    return ThemeData.light().copyWith(
      // Scaffold
      scaffoldBackgroundColor: PortfolioColors.bgLight,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: PortfolioColors.accent,
        secondary: PortfolioColors.accent,
        surface: PortfolioColors.bgCardLight,
        onPrimary: Colors.black,
        onSurface: PortfolioColors.textPrimaryLight,
      ),

      // App bar
      appBarTheme: const AppBarTheme(
        backgroundColor: PortfolioColors.bgLight,
        foregroundColor: PortfolioColors.textPrimaryLight,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      // Card
      cardTheme: CardThemeData(
        color: PortfolioColors.bgCardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: PortfolioColors.dividerLight),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: PortfolioColors.dividerLight,
        thickness: 1,
        space: 1,
      ),

      // Icon
      iconTheme: const IconThemeData(
        color: PortfolioColors.textSecondaryLight,
        size: 20,
      ),

      // Text
      textTheme: _buildTextTheme(
        primary: PortfolioColors.textPrimaryLight,
        secondary: PortfolioColors.textSecondaryLight,
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PortfolioColors.bgCardLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.dividerLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.dividerLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PortfolioColors.accent, width: 1.5),
        ),
        hintStyle: const TextStyle(color: PortfolioColors.textSecondaryLight),
        labelStyle: const TextStyle(color: PortfolioColors.textSecondaryLight),
      ),

      // Elevated button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PortfolioColors.accent,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PortfolioColors.textPrimaryLight,
          side: const BorderSide(color: PortfolioColors.dividerLight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PortfolioColors.accent,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),

      // Progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: PortfolioColors.accent,
        linearTrackColor: PortfolioColors.dividerLight,
      ),

      // List tile
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        textColor: PortfolioColors.textPrimaryLight,
        iconColor: PortfolioColors.textSecondaryLight,
      ),
    );
  }

  // ── Shared Text Theme ──────────────────────────────────────────────────────
  static TextTheme _buildTextTheme({
    required Color primary,
    required Color secondary,
  }) {
    return TextTheme(
      // Display — large hero headings
      displayLarge: TextStyle(
        color: primary, fontSize: 48, fontWeight: FontWeight.w800,
        height: 1.1, letterSpacing: -1.0,
      ),
      displayMedium: TextStyle(
        color: primary, fontSize: 40, fontWeight: FontWeight.w800,
        height: 1.15, letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        color: primary, fontSize: 32, fontWeight: FontWeight.w800,
        height: 1.2, letterSpacing: -0.5,
      ),

      // Headline — section headings
      headlineLarge: TextStyle(
        color: primary, fontSize: 28, fontWeight: FontWeight.w700, height: 1.3,
      ),
      headlineMedium: TextStyle(
        color: primary, fontSize: 24, fontWeight: FontWeight.w700, height: 1.3,
      ),
      headlineSmall: TextStyle(
        color: primary, fontSize: 20, fontWeight: FontWeight.w700, height: 1.35,
      ),

      // Title — card titles
      titleLarge: TextStyle(
        color: primary, fontSize: 18, fontWeight: FontWeight.w600, height: 1.4,
      ),
      titleMedium: TextStyle(
        color: primary, fontSize: 16, fontWeight: FontWeight.w600, height: 1.4,
      ),
      titleSmall: TextStyle(
        color: primary, fontSize: 14, fontWeight: FontWeight.w600, height: 1.4,
      ),

      // Body — paragraph / description text
      bodyLarge: TextStyle(
        color: secondary, fontSize: 16, fontWeight: FontWeight.w400, height: 1.7,
      ),
      bodyMedium: TextStyle(
        color: secondary, fontSize: 14, fontWeight: FontWeight.w400, height: 1.7,
      ),
      bodySmall: TextStyle(
        color: secondary, fontSize: 13, fontWeight: FontWeight.w400, height: 1.65,
      ),

      // Label — chips, tags, badges
      labelLarge: TextStyle(
        color: secondary, fontSize: 13, fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: secondary, fontSize: 12, fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: secondary, fontSize: 11, fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }
}
