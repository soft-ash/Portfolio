import 'package:flutter/material.dart';
import 'screen_size.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE BUILDER WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context) desktop;

  @override
  Widget build(BuildContext context) {
    return switch (ScreenSize.of(context)) {
      ScreenType.mobile => mobile(context),
      ScreenType.tablet => (tablet ?? desktop)(context),
      ScreenType.desktop => desktop(context),
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTENT WIDTH CONSTRAINT
// Constrains content to max width and adds horizontal padding
// ─────────────────────────────────────────────────────────────────────────────

class MaxWidthContainer extends StatelessWidget {
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200.0,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenSize.isMobile(context);
    final isTablet = ScreenSize.isTablet(context);

    final horizontalPadding = isMobile
        ? 24.0
        : isTablet
            ? 40.0
            : 64.0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RESPONSIVE GRID
// ─────────────────────────────────────────────────────────────────────────────

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.crossAxisSpacing = 24.0,
    this.mainAxisSpacing = 24.0,
    this.childAspectRatio = 1.0,
  });

  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final columns = ScreenSize.value(
      context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );

    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      children: children,
    );
  }
}
