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
import '../../../core/widgets/technology_chip.dart';
import '../controller/experience_controller.dart';
import '../../../data/models/experience_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// EXPERIENCE SECTION — Animated timeline
// ─────────────────────────────────────────────────────────────────────────────

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<ExperienceController>();
      final isMobile = ScreenSize.isMobile(context);

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
          vertical: AppSpacing.section,
        ),
        color: isDark ? AppColors.darkSurfaceElevated.withOpacity(0.3) : AppColors.lightSurfaceElevated,
        child: MaxWidthContainer(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: 'Experience',
                  title: 'Where I\'ve worked',
                  subtitle: 'A journey through the companies and roles that shaped my skills.',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              if (controller.isLoading.value)
                const CircularProgressIndicator(color: AppColors.accent)
              else
                ...controller.experiences.asMap().entries.map(
                      (e) => AnimatedSection(
                        delay: Duration(milliseconds: e.key * 150),
                        child: _ExperienceItem(
                          experience: e.value,
                          isDark: isDark,
                          isLast: e.key == controller.experiences.length - 1,
                          isMobile: isMobile,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}

class _ExperienceItem extends StatefulWidget {
  const _ExperienceItem({
    required this.experience,
    required this.isDark,
    required this.isLast,
    required this.isMobile,
  });

  final ExperienceModel experience;
  final bool isDark;
  final bool isLast;
  final bool isMobile;

  @override
  State<_ExperienceItem> createState() => _ExperienceItemState();
}

class _ExperienceItemState extends State<_ExperienceItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              // Dot
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.experience.isCurrent
                      ? AppColors.teal
                      : AppColors.accent,
                  boxShadow: [
                    BoxShadow(
                      color: (widget.experience.isCurrent
                              ? AppColors.teal
                              : AppColors.accent)
                          .withOpacity(0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              // Line
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    margin: const EdgeInsets.only(top: 8, bottom: 0),
                    color: AppColors.darkBorder,
                  ),
                ),
            ],
          ),

          const SizedBox(width: AppSpacing.lg),

          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.xxl),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _expanded
                            ? AppColors.accent.withOpacity(0.3)
                            : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.experience.position,
                                          style: AppTextStyles.headingSm(isDark: widget.isDark),
                                        ),
                                      ),
                                      if (widget.experience.isCurrent)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.teal.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(
                                              color: AppColors.teal.withOpacity(0.4),
                                            ),
                                          ),
                                          child: Text(
                                            'Current',
                                            style: AppTextStyles.labelSm()
                                                .copyWith(color: AppColors.teal),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.experience.company,
                                    style: AppTextStyles.bodyMd(isDark: widget.isDark)
                                        .copyWith(color: AppColors.accent, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          size: 12,
                                          color: AppColors.darkTextMuted),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.experience.dateRange,
                                        style: AppTextStyles.labelSm(isDark: widget.isDark),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(Icons.location_on_outlined,
                                          size: 12,
                                          color: AppColors.darkTextMuted),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          widget.experience.location,
                                          style: AppTextStyles.labelSm(isDark: widget.isDark),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            AnimatedRotation(
                              turns: _expanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.darkTextMuted,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.md),
                        Text(
                          widget.experience.description,
                          style: AppTextStyles.bodyMd(isDark: widget.isDark),
                          maxLines: _expanded ? null : 2,
                          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        ),

                        // Expanded content
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          crossFadeState: _expanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: const SizedBox.shrink(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppSpacing.md),
                              const Divider(),
                              const SizedBox(height: AppSpacing.md),

                              // Responsibilities
                              if (widget.experience.responsibilities.isNotEmpty) ...[
                                Text('Key Responsibilities',
                                    style: AppTextStyles.labelLg(isDark: widget.isDark)),
                                const SizedBox(height: AppSpacing.sm),
                                ...widget.experience.responsibilities.map(
                                  (r) => Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('→  ',
                                            style: AppTextStyles.bodySm()
                                                .copyWith(color: AppColors.accent)),
                                        Expanded(
                                          child: Text(r,
                                              style: AppTextStyles.bodySm(isDark: widget.isDark)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                              ],

                              // Technologies
                              if (widget.experience.technologies.isNotEmpty) ...[
                                Text('Technologies',
                                    style: AppTextStyles.labelLg(isDark: widget.isDark)),
                                const SizedBox(height: AppSpacing.sm),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: widget.experience.technologies
                                      .map((t) => TechnologyChip(
                                            label: t,
                                            isDark: widget.isDark,
                                            small: true,
                                          ))
                                      .toList(),
                                ),
                              ],

                              // Achievements
                              if (widget.experience.achievements.isNotEmpty) ...[
                                const SizedBox(height: AppSpacing.md),
                                Text('Achievements',
                                    style: AppTextStyles.labelLg(isDark: widget.isDark)),
                                const SizedBox(height: AppSpacing.sm),
                                ...widget.experience.achievements.map(
                                  (a) => Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('🏆  ',
                                            style: AppTextStyles.bodySm()),
                                        Expanded(
                                          child: Text(a,
                                              style: AppTextStyles.bodySm(isDark: widget.isDark)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
