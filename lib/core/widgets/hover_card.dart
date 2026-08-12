import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_shadows.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOVER CARD — Card with hover lift + glow effect
// ─────────────────────────────────────────────────────────────────────────────

class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.isDark = true,
    this.borderRadius,
    this.padding,
    this.glowOnHover = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool isDark;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool glowOnHover;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? AppRadius.radiusLg;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -4.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: radius,
            color: widget.isDark
                ? AppColors.darkSurface
                : AppColors.lightSurface,
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.4)
                  : (widget.isDark
                      ? AppColors.darkBorder
                      : AppColors.lightBorder),
              width: 1,
            ),
            boxShadow: _hovered && widget.glowOnHover
                ? AppShadows.cardHover
                : AppShadows.card,
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
