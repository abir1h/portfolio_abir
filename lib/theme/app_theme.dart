import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Core Palette ──────────────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB);
  static const Color accent = Color(0xFF38BDF8);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color emerald = Color(0xFF10B981);

  // ── Surfaces ──────────────────────────────────────────────────────────
  static const Color bgDark = Color(0xFF050816);
  static const Color surfaceDark = Color(0xFF0A0D1F);
  static const Color cardBg = Color(0x0DFFFFFF); // 5% white
  static const Color cardBgHover = Color(0x14FFFFFF); // 8% white
  static const Color borderSubtle = Color(0x14FFFFFF); // 8% white
  static const Color borderHover = Color(0x33FFFFFF); // 20% white

  // ── Text Palette ──────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFFCBD5E1);
  static const Color textMuted = Color(0xFF94A3B8);

  // ── Spacing ───────────────────────────────────────────────────────────
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2Xl = 48;
  static const double spacing3Xl = 64;
  static const double spacing4Xl = 96;

  // ── Breakpoints ───────────────────────────────────────────────────────
  static const double mobileBreak = 720;
  static const double tabletBreak = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreak;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileBreak && w < tabletBreak;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreak;

  // ── Border Radius ─────────────────────────────────────────────────────
  static const double radiusSm = 12;
  static const double radiusMd = 20;
  static const double radiusLg = 28;
  static const double radiusXl = 36;

  // ── Gradients ─────────────────────────────────────────────────────────
  static LinearGradient get heroGradient => const LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF050816)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF38BDF8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get accentGradient => const LinearGradient(
        colors: [Color(0xFF38BDF8), Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // ── Shadows ───────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 30,
          offset: const Offset(0, 10),
          spreadRadius: -5,
        ),
      ];

  static List<BoxShadow> hoverGlow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 30,
          offset: const Offset(0, 12),
          spreadRadius: -4,
        ),
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 60,
          offset: const Offset(0, 24),
          spreadRadius: -10,
        ),
      ];

  // ── Glass Card Decoration ─────────────────────────────────────────────
  static BoxDecoration glassCard({
    double borderRadius = radiusLg,
    bool hovered = false,
    Color? accentColor,
  }) {
    return BoxDecoration(
      color: hovered ? cardBgHover : cardBg,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: hovered
            ? (accentColor?.withValues(alpha: 0.4) ?? borderHover)
            : borderSubtle,
        width: hovered ? 1.5 : 1,
      ),
      boxShadow: hovered ? hoverGlow(accentColor ?? primary) : cardShadow,
    );
  }

  // ── Section Container ─────────────────────────────────────────────────
  static BoxDecoration sectionContainer() {
    return BoxDecoration(
      color: const Color(0x08FFFFFF),
      borderRadius: BorderRadius.circular(radiusXl),
      border: Border.all(color: const Color(0x0AFFFFFF)),
    );
  }

  // ── Theme Data ────────────────────────────────────────────────────────
  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
        brightness: Brightness.dark,
        surface: surfaceDark,
      ),
    );

    final displayFont = GoogleFonts.spaceGrotesk;
    final bodyFont = GoogleFonts.inter;

    final textTheme = base.textTheme.copyWith(
      // Display — Hero name
      displayLarge: displayFont(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: textPrimary,
        height: 1.05,
        letterSpacing: -2.5,
      ),
      // Display — Section heading
      displayMedium: displayFont(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        height: 1.2,
        letterSpacing: -1.0,
      ),
      // Display — Card title
      displaySmall: displayFont(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        height: 1.3,
      ),
      // Headline
      headlineLarge: displayFont(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineMedium: displayFont(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      // Title
      titleLarge: bodyFont(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: bodyFont(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleSmall: bodyFont(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      // Body
      bodyLarge: bodyFont(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.7,
      ),
      bodyMedium: bodyFont(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
      ),
      bodySmall: bodyFont(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textMuted,
        height: 1.5,
      ),
      // Label
      labelLarge: bodyFont(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textSecondary,
        letterSpacing: 0.5,
      ),
      labelMedium: bodyFont(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMuted,
        letterSpacing: 0.8,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: bgDark,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0x14FFFFFF),
        labelStyle: bodyFont(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textSecondary,
        ),
        side: const BorderSide(color: Color(0x1AFFFFFF)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
    );
  }
}
