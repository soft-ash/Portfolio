import 'package:flutter/material.dart';
import 'app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN SYSTEM — SHADOW TOKENS
// ─────────────────────────────────────────────────────────────────────────────

class AppShadows {
  AppShadows._();

  static List<BoxShadow> get card => [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get cardHover => [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 30,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: AppColors.accent.withOpacity(0.15),
          blurRadius: 40,
          offset: const Offset(0, 0),
        ),
      ];

  static List<BoxShadow> get accentGlow => [
        BoxShadow(
          color: AppColors.accent.withOpacity(0.3),
          blurRadius: 30,
          spreadRadius: -5,
          offset: const Offset(0, 0),
        ),
      ];

  static List<BoxShadow> get tealGlow => [
        BoxShadow(
          color: AppColors.teal.withOpacity(0.3),
          blurRadius: 30,
          spreadRadius: -5,
          offset: const Offset(0, 0),
        ),
      ];

  static List<BoxShadow> get navBar => [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get light => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: AppColors.accent.withOpacity(0.08),
          blurRadius: 40,
          offset: const Offset(0, 0),
        ),
      ];
}
