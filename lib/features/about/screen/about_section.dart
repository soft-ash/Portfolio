import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../app/constants/profile_constants.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/widgets/animated_section.dart';
import '../../../core/widgets/section_header.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ABOUT SECTION
// ─────────────────────────────────────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
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
                  label: 'About Me',
                  title: 'Passionate about building\ngreat software',
                  subtitle: ProfileConstants.bio,
                  isDark: isDark,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Highlight cards grid
              AnimatedSection(
                child: ResponsiveBuilder(
                  mobile: (context) => _AboutCardsColumn(isDark: isDark),
                  tablet: (context) => _AboutCardsGrid(isDark: isDark, columns: 2),
                  desktop: (context) => _AboutCardsGrid(isDark: isDark, columns: 3),
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Philosophy quote
              AnimatedSection(
                child: _PhilosophyCard(isDark: isDark),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // What I do list
              AnimatedSection(
                child: _WhatIDoSection(isDark: isDark, isMobile: isMobile),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _AboutCardsGrid extends StatelessWidget {
  const _AboutCardsGrid({required this.isDark, required this.columns});
  final bool isDark;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardWidth = (constraints.maxWidth - (columns - 1) * AppSpacing.lg) / columns;
      return Wrap(
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.lg,
        children: _aboutCards(isDark)
            .asMap()
            .entries
            .map((e) => SizedBox(
                  width: cardWidth,
                  child: e.value.animate(delay: Duration(milliseconds: e.key * 100)),
                ))
            .toList(),
      );
    });
  }
}

class _AboutCardsColumn extends StatelessWidget {
  const _AboutCardsColumn({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _aboutCards(isDark)
          .asMap()
          .entries
          .map((e) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                child: e.value.animate(delay: Duration(milliseconds: e.key * 100)),
              ))
          .toList(),
    );
  }
}

List<Widget> _aboutCards(bool isDark) => [
      _AboutCard(
        emoji: '📱',
        title: 'Mobile Expert',
        description: 'Crafting beautiful, performant apps for Android and iOS using Flutter.',
        isDark: isDark,
        accentColor: AppColors.accent,
      ),
      _AboutCard(
        emoji: '🌐',
        title: 'Web Developer',
        description: 'Building fast, responsive Flutter Web applications for modern browsers.',
        isDark: isDark,
        accentColor: AppColors.teal,
      ),
      _AboutCard(
        emoji: '🤖',
        title: 'AI Enthusiast',
        description: 'Integrating LLMs and ML models to create intelligent applications.',
        isDark: isDark,
        accentColor: AppColors.rose,
      ),
      _AboutCard(
        emoji: '⚡',
        title: 'Performance',
        description: 'Obsessed with smooth 60fps experiences and optimized build sizes.',
        isDark: isDark,
        accentColor: AppColors.amber,
      ),
      _AboutCard(
        emoji: '🏗️',
        title: 'Clean Architecture',
        description: 'Designing maintainable, scalable codebases that stand the test of time.',
        isDark: isDark,
        accentColor: AppColors.sky,
      ),
      _AboutCard(
        emoji: '🎨',
        title: 'UI/UX Design',
        description: 'Translating designs into pixel-perfect, accessible user interfaces.',
        isDark: isDark,
        accentColor: AppColors.accentLight,
      ),
    ];

class _AboutCard extends StatefulWidget {
  const _AboutCard({
    required this.emoji,
    required this.title,
    required this.description,
    required this.isDark,
    required this.accentColor,
  });

  final String emoji;
  final String title;
  final String description;
  final bool isDark;
  final Color accentColor;

  @override
  State<_AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<_AboutCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppSpacing.xl),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withOpacity(0.4)
                : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(widget.emoji, style: const TextStyle(fontSize: 22)),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              widget.title,
              style: AppTextStyles.headingSm(isDark: widget.isDark),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.description,
              style: AppTextStyles.bodySm(isDark: widget.isDark),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhilosophyCard extends StatelessWidget {
  const _PhilosophyCard({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.08),
            AppColors.teal.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote_rounded,
            color: AppColors.accent,
            size: 36,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            ProfileConstants.philosophy,
            style: AppTextStyles.headingMd(isDark: isDark).copyWith(
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '— ${ProfileConstants.fullName}',
            style: AppTextStyles.labelMd(isDark: isDark).copyWith(
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _WhatIDoSection extends StatelessWidget {
  const _WhatIDoSection({required this.isDark, required this.isMobile});
  final bool isDark;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What I Do',
                  style: AppTextStyles.headingLg(isDark: isDark),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Areas where I can add value to your team or project.',
                  style: AppTextStyles.bodyMd(isDark: isDark),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xxl),
        ],
        Expanded(
          flex: isMobile ? 1 : 2,
          child: Column(
            children: ProfileConstants.whatIDo
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.accent,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            e.value,
                            style: AppTextStyles.bodyMd(isDark: isDark),
                          ),
                        ),
                      ],
                    )
                        .animate(delay: Duration(milliseconds: e.key * 80))
                        .fadeIn(duration: 400.ms)
                        .slideX(begin: 0.2, end: 0, duration: 400.ms),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
