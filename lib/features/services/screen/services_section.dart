import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/widgets/animated_section.dart';
import '../../../core/widgets/section_header.dart';
import '../controller/services_controller.dart';
import '../../../data/models/service_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<ServicesController>();
      final isMobile = ScreenSize.isMobile(context);

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
          vertical: AppSpacing.section,
        ),
        child: MaxWidthContainer(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: 'Services',
                  title: 'What I can build for you',
                  subtitle: 'Comprehensive software development services from mobile apps to AI integrations.',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              AnimatedSection(
                child: LayoutBuilder(builder: (context, constraints) {
                  final columns = isMobile ? 1 : (ScreenSize.isTablet(context) ? 2 : 3);
                  final spacing = AppSpacing.lg;
                  final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: controller.services.asMap().entries.map((e) {
                      return SizedBox(
                        width: isMobile ? double.infinity : width,
                        child: _ServiceCard(service: e.value, isDark: isDark),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({required this.service, required this.isDark});
  final ServiceModel service;
  final bool isDark;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  Color get _accent {
    if (widget.service.accentColorHex == null) return AppColors.accent;
    try {
      return Color(int.parse(widget.service.accentColorHex!.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.5)
                : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.2),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: accent.withOpacity(0.3)),
              ),
              child: Center(
                child: Text(
                  widget.service.emojiIcon ?? '⚡',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              widget.service.title,
              style: AppTextStyles.headingSm(isDark: widget.isDark),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.service.description,
              style: AppTextStyles.bodySm(isDark: widget.isDark),
            ),
            if (widget.service.features.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              ...widget.service.features.map(
                (f) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(f, style: AppTextStyles.labelMd(isDark: widget.isDark)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
