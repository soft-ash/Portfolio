import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/animated_section.dart';
import '../../../core/widgets/section_header.dart';
import '../controller/certifications_controller.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<CertificationsController>();
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
                  label: 'Certifications',
                  title: 'Credentials & achievements',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              LayoutBuilder(builder: (context, constraints) {
                final columns = isMobile ? 1 : (ScreenSize.isTablet(context) ? 2 : 2);
                final spacing = AppSpacing.lg;
                final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: controller.certifications
                      .asMap()
                      .entries
                      .map(
                        (e) => SizedBox(
                          width: isMobile ? double.infinity : width,
                          child: AnimatedSection(
                            delay: Duration(milliseconds: e.key * 80),
                            child: _CertCard(
                              title: e.value.title,
                              organization: e.value.organization,
                              issueDate: e.value.issueDate,
                              credentialUrl: e.value.credentialUrl,
                              credentialId: e.value.credentialId,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}

class _CertCard extends StatefulWidget {
  const _CertCard({
    required this.title,
    required this.organization,
    required this.issueDate,
    this.credentialUrl,
    this.credentialId,
    required this.isDark,
  });

  final String title;
  final String organization;
  final String issueDate;
  final String? credentialUrl;
  final String? credentialId;
  final bool isDark;

  @override
  State<_CertCard> createState() => _CertCardState();
}

class _CertCardState extends State<_CertCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.credentialUrl != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.credentialUrl != null
            ? () => UrlLauncherUtil.launch(widget.credentialUrl!)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -4.0))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.4)
                  : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text('🏅', style: TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.labelLg(isDark: widget.isDark),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.organization,
                      style: AppTextStyles.bodyMd(isDark: widget.isDark)
                          .copyWith(color: AppColors.accent, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.issueDate,
                      style: AppTextStyles.labelSm(isDark: widget.isDark),
                    ),
                  ],
                ),
              ),
              if (widget.credentialUrl != null)
                Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: _hovered ? AppColors.accent : AppColors.darkTextMuted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
