import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED SECTION — Triggers fade-in + slide-up when scrolled into view
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedSection extends StatefulWidget {
  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.visibilityFraction = 0.1,
    this.slideFromBottom = true,
  });

  final Widget child;
  final Duration delay;
  final double visibilityFraction;
  final bool slideFromBottom;

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late final String _key = UniqueKey().toString();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_key),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction >= widget.visibilityFraction) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible
              ? Offset.zero
              : (widget.slideFromBottom
                  ? const Offset(0, 0.05)
                  : const Offset(-0.05, 0)),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STAGGERED ANIMATION — Wraps children with sequential delays
// ─────────────────────────────────────────────────────────────────────────────

class StaggeredList extends StatelessWidget {
  const StaggeredList({
    super.key,
    required this.children,
    this.baseDelay = const Duration(milliseconds: 100),
    this.direction = Axis.vertical,
  });

  final List<Widget> children;
  final Duration baseDelay;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
          .asMap()
          .entries
          .map(
            (entry) => entry.value
                .animate(delay: baseDelay * entry.key)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOut),
          )
          .toList(),
    );
  }
}
