import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF2563EB);
  static const Color accent = Color(0xFF38BDF8);
  static const Color surface = Color(0xFF0F172A);

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
        brightness: Brightness.light,
      ),
    );

    final textTheme = GoogleFonts.spaceGroteskTextTheme(base.textTheme)
        .copyWith(
          displayLarge: GoogleFonts.spaceGrotesk(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.spaceGrotesk(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFF050816),
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.04),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: Colors.white.withValues(alpha: 0.08),
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.9)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static LinearGradient get heroGradient => const LinearGradient(
    colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get surfaceGradient => const LinearGradient(
    colors: [Color(0x661D4ED8), Color(0x330F172A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
