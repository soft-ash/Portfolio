import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/animated_section.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/technology_chip.dart';
import '../controller/projects_controller.dart';
import '../../../data/models/project_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROJECTS SECTION — Featured + all projects grid
// ─────────────────────────────────────────────────────────────────────────────

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<ProjectsController>();
      final isMobile = ScreenSize.isMobile(context);

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
          vertical: AppSpacing.section,
        ),
        color: isDark
            ? AppColors.darkSurfaceElevated.withOpacity(0.3)
            : AppColors.lightSurfaceElevated,
        child: MaxWidthContainer(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: 'Projects',
                  title: 'Things I\'ve built',
                  subtitle: 'A selection of projects showcasing my skills across mobile, web, AI, and backend development.',
                  isDark: isDark,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Featured projects
              if (controller.featuredProjects.isNotEmpty) ...[
                AnimatedSection(
                  child: Row(
                    children: [
                      Text(
                        'Featured Projects',
                        style: AppTextStyles.headingMd(isDark: isDark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AnimatedSection(
                  child: _FeaturedProjectsGrid(
                    projects: controller.featuredProjects,
                    isDark: isDark,
                    isMobile: isMobile,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxxl),

                // Other projects
                AnimatedSection(
                  child: Row(
                    children: [
                      Text('Other Projects',
                          style: AppTextStyles.headingMd(isDark: isDark)),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],

              // All non-featured projects
              AnimatedSection(
                child: _ProjectsGrid(
                  projects: controller.projects.where((p) => !p.featured).toList(),
                  isDark: isDark,
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _FeaturedProjectsGrid extends StatelessWidget {
  const _FeaturedProjectsGrid({
    required this.projects,
    required this.isDark,
    required this.isMobile,
  });

  final List<ProjectModel> projects;
  final bool isDark;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: projects
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _ProjectCard(
                    project: e.value,
                    isDark: isDark,
                    featured: true,
                  ).animate(delay: Duration(milliseconds: e.key * 100)),
                ))
            .toList(),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.lg,
        children: projects.asMap().entries.map((e) {
          final width = e.key == 0 && projects.length >= 2
              ? constraints.maxWidth
              : (constraints.maxWidth - AppSpacing.lg) / 2;
          return SizedBox(
            width: width.clamp(0, constraints.maxWidth),
            child: _ProjectCard(
              project: e.value,
              isDark: isDark,
              featured: e.key == 0,
            ).animate(delay: Duration(milliseconds: e.key * 100)),
          );
        }).toList(),
      );
    });
  }
}

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({
    required this.projects,
    required this.isDark,
    required this.isMobile,
  });

  final List<ProjectModel> projects;
  final bool isDark;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final columns = isMobile ? 1 : (ScreenSize.isTablet(context) ? 2 : 3);
      final spacing = AppSpacing.lg;
      final width = (constraints.maxWidth - spacing * (columns - 1)) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: projects.asMap().entries.map((e) {
          return SizedBox(
            width: isMobile ? double.infinity : width,
            child: _ProjectCard(
              project: e.value,
              isDark: isDark,
              featured: false,
            ).animate(delay: Duration(milliseconds: e.key * 80)),
          );
        }).toList(),
      );
    });
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.project,
    required this.isDark,
    required this.featured,
  });

  final ProjectModel project;
  final bool isDark;
  final bool featured;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.projectDetailPath(widget.project.id)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.5)
                  : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project header banner
              Container(
                height: widget.featured ? 200 : 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.accent.withOpacity(0.2),
                      AppColors.teal.withOpacity(0.15),
                      AppColors.darkSurface.withOpacity(0.3),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.code_rounded,
                        size: widget.featured ? 64 : 48,
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                        ),
                        child: Text(
                          widget.project.year.toString(),
                          style: AppTextStyles.labelSm().copyWith(color: AppColors.accent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      widget.project.category.toUpperCase(),
                      style: AppTextStyles.captionUppercase(),
                    ),
                    const SizedBox(height: 6),

                    // Title
                    Text(
                      widget.project.title,
                      style: AppTextStyles.headingSm(isDark: widget.isDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Description
                    Text(
                      widget.project.shortDescription,
                      style: AppTextStyles.bodySm(isDark: widget.isDark),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Technologies
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.technologies
                          .take(4)
                          .map((t) => TechnologyChip(
                                label: t,
                                isDark: widget.isDark,
                                small: true,
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: AppSpacing.md),
                    const Divider(),
                    const SizedBox(height: AppSpacing.sm),

                    // Actions
                    Row(
                      children: [
                        Text(
                          'View Details',
                          style: AppTextStyles.labelMd(isDark: widget.isDark).copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded,
                            size: 14, color: AppColors.accent),
                        const Spacer(),
                        if (widget.project.githubUrl != null)
                          IconButton(
                            onPressed: () =>
                                UrlLauncherUtil.launch(widget.project.githubUrl!),
                            icon: const Icon(Icons.code, size: 18),
                            color: AppColors.darkTextMuted,
                            tooltip: 'GitHub',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        if (widget.project.liveUrl != null) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () =>
                                UrlLauncherUtil.launch(widget.project.liveUrl!),
                            icon: const Icon(Icons.open_in_new_rounded, size: 18),
                            color: AppColors.darkTextMuted,
                            tooltip: 'Live Demo',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
