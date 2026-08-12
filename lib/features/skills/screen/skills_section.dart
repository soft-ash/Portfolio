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
import '../controller/skills_controller.dart';
import '../../../data/models/skill_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SKILLS SECTION — Categorized skill cards
// ─────────────────────────────────────────────────────────────────────────────

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<SkillsController>();
      final isMobile = ScreenSize.isMobile(context);

      final categories = controller.categories;

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
                  label: 'Skills',
                  title: 'Technologies I work with',
                  subtitle: 'A curated set of tools and technologies I use to bring ideas to life.',
                  isDark: isDark,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Category groups
              ...categories.asMap().entries.map(
                    (catEntry) {
                  final category = catEntry.value;
                  final skills = controller.skills
                      .where((s) => s.category == category)
                      .toList();

                  return AnimatedSection(
                    delay: Duration(milliseconds: catEntry.key * 80),
                    child: _SkillCategory(
                      category: category,
                      skills: skills,
                      isDark: isDark,
                      isMobile: isMobile,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SkillCategory extends StatelessWidget {
  const _SkillCategory({
    required this.category,
    required this.skills,
    required this.isDark,
    required this.isMobile,
  });

  final SkillCategory category;
  final List<SkillModel> skills;
  final bool isDark;
  final bool isMobile;

  static const _categoryColors = {
    SkillCategory.mobile: AppColors.accent,
    SkillCategory.stateManagement: AppColors.teal,
    SkillCategory.backend: AppColors.sky,
    SkillCategory.programming: AppColors.amber,
    SkillCategory.aiMl: AppColors.rose,
    SkillCategory.tools: AppColors.accentLight,
    SkillCategory.design: AppColors.tealDark,
  };

  @override
  Widget build(BuildContext context) {
    final color = _categoryColors[category] ?? AppColors.accent;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 6),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                category.label,
                style: AppTextStyles.headingMd(isDark: isDark),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Skill chips
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: skills.asMap().entries.map((e) {
              return _SkillChip(
                skill: e.value,
                isDark: isDark,
                color: color,
                delay: Duration(milliseconds: e.key * 40),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({
    required this.skill,
    required this.isDark,
    required this.color,
    required this.delay,
  });

  final SkillModel skill;
  final bool isDark;
  final Color color;
  final Duration delay;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withOpacity(0.12)
              : (widget.isDark ? AppColors.darkSurface : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? widget.color.withOpacity(0.5)
                : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.skill.name,
          style: AppTextStyles.labelLg(isDark: widget.isDark).copyWith(
            color: _hovered
                ? widget.color
                : (widget.isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
          ),
        ),
      ),
    );
  }
}
