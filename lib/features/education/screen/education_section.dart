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
import '../controller/education_controller.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<EducationController>();
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
                  label: 'Education',
                  title: 'Academic background',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              ...controller.education.asMap().entries.map(
                    (e) => AnimatedSection(
                      delay: Duration(milliseconds: e.key * 100),
                      child: _EducationCard(
                        institution: e.value.institution,
                        degree: e.value.degree,
                        major: e.value.major,
                        yearRange: e.value.yearRange,
                        cgpa: e.value.cgpa,
                        description: e.value.description,
                        isDark: isDark,
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

class _EducationCard extends StatelessWidget {
  const _EducationCard({
    required this.institution,
    required this.degree,
    required this.major,
    required this.yearRange,
    this.cgpa,
    this.description,
    required this.isDark,
  });

  final String institution;
  final String degree;
  final String major;
  final String yearRange;
  final String? cgpa;
  final String? description;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xl),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
            ),
            child: const Center(
              child: Text('🎓', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(institution, style: AppTextStyles.headingSm(isDark: isDark)),
                const SizedBox(height: 4),
                Text(
                  '$degree in $major',
                  style: AppTextStyles.bodyMd(isDark: isDark)
                      .copyWith(color: AppColors.accent, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 13, color: AppColors.darkTextMuted),
                    const SizedBox(width: 6),
                    Text(yearRange, style: AppTextStyles.labelSm(isDark: isDark)),
                    if (cgpa != null) ...[
                      const SizedBox(width: 16),
                      Icon(Icons.star_outline_rounded,
                          size: 13, color: AppColors.amber),
                      const SizedBox(width: 4),
                      Text('CGPA: $cgpa',
                          style: AppTextStyles.labelSm(isDark: isDark)
                              .copyWith(color: AppColors.amber)),
                    ],
                  ],
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(description!, style: AppTextStyles.bodySm(isDark: isDark)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
