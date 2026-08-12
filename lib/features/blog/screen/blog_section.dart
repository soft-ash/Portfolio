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
import '../controller/blog_controller.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<BlogController>();
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
                  label: 'Blog',
                  title: 'Thoughts & articles',
                  subtitle: 'Technical writing on Flutter, mobile development, AI integrations, and software engineering.',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              AnimatedSection(
                child: LayoutBuilder(builder: (context, constraints) {
                  final columns = isMobile ? 1 : (ScreenSize.isTablet(context) ? 2 : 2);
                  final spacing = AppSpacing.lg;
                  final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: controller.posts.asMap().entries.map((e) {
                      final post = e.value;
                      return SizedBox(
                        width: isMobile ? double.infinity : width,
                        child: _BlogCard(
                          title: post.title,
                          excerpt: post.excerpt,
                          publishedDate: post.publishedDate,
                          tags: post.tags,
                          readingTime: post.readingTime,
                          externalUrl: post.externalUrl,
                          isDark: isDark,
                        ),
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

class _BlogCard extends StatefulWidget {
  const _BlogCard({
    required this.title,
    required this.excerpt,
    required this.publishedDate,
    required this.tags,
    required this.readingTime,
    this.externalUrl,
    required this.isDark,
  });

  final String title;
  final String excerpt;
  final String publishedDate;
  final List<String> tags;
  final int readingTime;
  final String? externalUrl;
  final bool isDark;

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.externalUrl != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.externalUrl != null
            ? () => UrlLauncherUtil.launch(widget.externalUrl!)
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
                ? [BoxShadow(color: AppColors.accent.withOpacity(0.1), blurRadius: 20)]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tags
              Wrap(
                spacing: 8,
                children: widget.tags
                    .take(3)
                    .map(
                      (t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          t,
                          style: AppTextStyles.labelSm(isDark: widget.isDark)
                              .copyWith(color: AppColors.accent),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.title,
                style: AppTextStyles.headingSm(isDark: widget.isDark),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.excerpt,
                style: AppTextStyles.bodySm(isDark: widget.isDark),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 12, color: AppColors.darkTextMuted),
                  const SizedBox(width: 4),
                  Text(widget.publishedDate,
                      style: AppTextStyles.labelSm(isDark: widget.isDark)),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time_rounded,
                      size: 12, color: AppColors.darkTextMuted),
                  const SizedBox(width: 4),
                  Text('${widget.readingTime} min read',
                      style: AppTextStyles.labelSm(isDark: widget.isDark)),
                  const Spacer(),
                  if (widget.externalUrl != null)
                    Row(
                      children: [
                        Text(
                          'Read More',
                          style: AppTextStyles.labelMd(isDark: widget.isDark)
                              .copyWith(color: AppColors.accent),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded,
                            size: 14, color: AppColors.accent),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
