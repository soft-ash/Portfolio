import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE SYSTEM — SCREEN SIZE BREAKPOINTS
// ─────────────────────────────────────────────────────────────────────────────

enum ScreenType { mobile, tablet, desktop }

class ScreenSize {
  ScreenSize._();

  static const double mobile = 768.0;
  static const double tablet = 1024.0;

  static ScreenType of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobile) return ScreenType.mobile;
    if (width < tablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobile && w < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  static bool isMobileOrTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < tablet;

  /// Responsive value shorthand
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final type = of(context);
    return switch (type) {
      ScreenType.mobile => mobile,
      ScreenType.tablet => tablet ?? desktop,
      ScreenType.desktop => desktop,
    };
  }
}
