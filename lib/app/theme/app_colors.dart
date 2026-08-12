import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN SYSTEM — COLOR PALETTE
// Premium dark-first color system inspired by Linear / Vercel aesthetics
// ─────────────────────────────────────────────────────────────────────────────

class AppColors {
  AppColors._();

  // ── Dark Theme ────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0A0A0F);
  static const Color darkSurface = Color(0xFF12121A);
  static const Color darkSurfaceElevated = Color(0xFF1A1A26);
  static const Color darkBorder = Color(0xFF1E1E30);
  static const Color darkBorderLight = Color(0xFF2A2A40);
  static const Color darkMuted = Color(0xFF3A3A52);

  // ── Light Theme ───────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF6F6FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF0F0FA);
  static const Color lightBorder = Color(0xFFE8E8F0);
  static const Color lightBorderLight = Color(0xFFD8D8EC);
  static const Color lightMuted = Color(0xFFB8B8D0);

  // ── Accent Colors ─────────────────────────────────────────────────────────
  static const Color accent = Color(0xFF7C6EFA);       // Electric violet
  static const Color accentDark = Color(0xFF6355E8);   // Darker violet
  static const Color accentLight = Color(0xFF9E93FF);  // Lighter violet
  static const Color accentGlow = Color(0x337C6EFA);   // Glow effect

  static const Color teal = Color(0xFF00D4AA);         // Teal accent
  static const Color tealDark = Color(0xFF00B894);     // Darker teal
  static const Color tealGlow = Color(0x3300D4AA);     // Teal glow

  static const Color rose = Color(0xFFFF6B8A);         // Rose accent
  static const Color amber = Color(0xFFFFB347);        // Amber accent
  static const Color sky = Color(0xFF38BDF8);          // Sky blue

  // ── Text Colors ───────────────────────────────────────────────────────────
  static const Color darkTextPrimary = Color(0xFFF0F0F8);
  static const Color darkTextSecondary = Color(0xFF8A8AA8);
  static const Color darkTextMuted = Color(0xFF5A5A78);

  static const Color lightTextPrimary = Color(0xFF0A0A1A);
  static const Color lightTextSecondary = Color(0xFF5A5A78);
  static const Color lightTextMuted = Color(0xFF9A9AB8);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A0A0F), Color(0xFF0E0E1C), Color(0xFF0A0A0F)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7C6EFA), Color(0xFF00D4AA)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF16162A), Color(0xFF12121A)],
  );

  static const LinearGradient lightCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF6F6FC)],
  );

  static const LinearGradient accentGradientHorizontal = LinearGradient(
    colors: [Color(0xFF7C6EFA), Color(0xFF9E93FF)],
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [Color(0xFF1A1A26), Color(0xFF22223A), Color(0xFF1A1A26)],
  );

  // ── Status Colors ─────────────────────────────────────────────────────────
  static const Color success = Color(0xFF00D4AA);
  static const Color error = Color(0xFFFF6B8A);
  static const Color warning = Color(0xFFFFB347);
  static const Color info = Color(0xFF38BDF8);

  // ── Convenience helpers ───────────────────────────────────────────────────
  static Color surfaceDark(bool isDark) =>
      isDark ? darkSurface : lightSurface;

  static Color backgroundDark(bool isDark) =>
      isDark ? darkBackground : lightBackground;

  static Color textPrimary(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;

  static Color textSecondary(bool isDark) =>
      isDark ? darkTextSecondary : lightTextSecondary;

  static Color border(bool isDark) =>
      isDark ? darkBorder : lightBorder;
}
