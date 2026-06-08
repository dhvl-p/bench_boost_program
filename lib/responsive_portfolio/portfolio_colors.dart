import 'package:flutter/material.dart';

/// Central color palette for the Responsive Portfolio UI.
/// All sections and widgets pull their colors from this single source of truth.
class PortfolioColors {
  PortfolioColors._(); // prevent instantiation

  // ── Backgrounds ────────────────────────────────────────────────────────────
  static const Color bgDark        = Color(0xFF0D0D0D);
  static const Color bgCardDark    = Color(0xFF161616);
  static const Color bgSectionDark = Color(0xFF111111);
  static const Color bgLight       = Color(0xFFF8F8F8);
  static const Color bgCardLight   = Color(0xFFFFFFFF);
  static const Color bgSectionLight= Color(0xFFF0F0F0);

  // ── Accent ─────────────────────────────────────────────────────────────────
  static const Color accent        = Color(0xFFE2B714); // Gold

  // ── Text ───────────────────────────────────────────────────────────────────
  static const Color textPrimaryDark   = Colors.white;
  static const Color textSecondaryDark = Color(0xFFAAAAAA);
  static const Color textPrimaryLight  = Color(0xFF111111);
  static const Color textSecondaryLight= Color(0xFF555555);

  // ── Status ─────────────────────────────────────────────────────────────────
  static const Color available     = Color(0xFF22C55E);

  // ── Borders & Dividers ────────────────────────────────────────────────────
  static const Color dividerDark   = Color(0xFF222222);
  static const Color dividerLight  = Color(0xFFE0E0E0);

  // ── Helpers: pick dark or light variant ───────────────────────────────────
  static Color bg(bool isDark)          => isDark ? bgDark          : bgLight;
  static Color bgCard(bool isDark)      => isDark ? bgCardDark      : bgCardLight;
  static Color bgSection(bool isDark)   => isDark ? bgSectionDark   : bgSectionLight;
  static Color textPrimary(bool isDark) => isDark ? textPrimaryDark : textPrimaryLight;
  static Color textSecondary(bool isDark)=> isDark ? textSecondaryDark : textSecondaryLight;
  static Color divider(bool isDark)     => isDark ? dividerDark     : dividerLight;
}
