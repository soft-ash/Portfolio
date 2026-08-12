import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/technology_chip.dart';
import '../controller/projects_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT DETAIL SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    final id = Get.parameters['id'] ?? '';
    Get.find<ProjectsController>().loadProjectById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final controller = Get.find<ProjectsController>();
      final project = controller.selectedProject.value;
      final isMobile = ScreenSize.isMobile(context);

      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: isDark
              ? AppColors.darkBackground.withOpacity(0.95)
              : AppColors.lightBackground.withOpacity(0.95),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          title: Text(
            project?.title ?? 'Project',
            style: AppTextStyles.headingSm(isDark: isDark),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              )
            : project == null
                ? Center(
                    child: Text(
                      'Project not found',
                      style: AppTextStyles.bodyLg(isDark: isDark),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero banner
                        Container(
                          height: isMobile ? 220 : 360,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.accent.withOpacity(0.15),
                                AppColors.teal.withOpacity(0.1),
                                isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.code_rounded,
                                  size: 72,
                                  color: AppColors.accent.withOpacity(0.4),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  project.category,
                                  style: AppTextStyles.captionUppercase(),
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
                            vertical: AppSpacing.xxl,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 900),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title + Year
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        project.title,
                                        style: AppTextStyles.displaySmall(isDark: isDark),
                                      )
                                          .animate()
                                          .fadeIn(duration: 500.ms)
                                          .slideY(begin: 0.2, end: 0, duration: 500.ms),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 7),
                                      decoration: BoxDecoration(
                                        color: AppColors.accent.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(
                                            color: AppColors.accent.withOpacity(0.3)),
                                      ),
                                      child: Text(
                                        project.year.toString(),
                                        style: AppTextStyles.labelMd()
                                            .copyWith(color: AppColors.accent),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: AppSpacing.md),

                                // Short description
                                Text(
                                  project.shortDescription,
                                  style: AppTextStyles.headingMd(isDark: isDark)
                                      .copyWith(color: AppColors.darkTextSecondary),
                                )
                                    .animate(delay: 100.ms)
                                    .fadeIn(duration: 500.ms),

                                const SizedBox(height: AppSpacing.xl),

                                // Action buttons
                                Wrap(
                                  spacing: AppSpacing.md,
                                  runSpacing: AppSpacing.sm,
                                  children: [
                                    if (project.githubUrl != null)
                                      PrimaryButton(
                                        label: 'GitHub',
                                        onTap: () => UrlLauncherUtil.launch(project.githubUrl!),
                                        icon: Icons.code,
                                        small: true,
                                      ),
                                    if (project.liveUrl != null)
                                      SecondaryButton(
                                        label: 'Live Demo',
                                        onTap: () => UrlLauncherUtil.launch(project.liveUrl!),
                                        icon: Icons.open_in_new_rounded,
                                        small: true,
                                        isDark: isDark,
                                      ),
                                    if (project.playStoreUrl != null)
                                      SecondaryButton(
                                        label: 'Play Store',
                                        onTap: () => UrlLauncherUtil.launch(project.playStoreUrl!),
                                        icon: Icons.shop_rounded,
                                        small: true,
                                        isDark: isDark,
                                      ),
                                  ],
                                )
                                    .animate(delay: 200.ms)
                                    .fadeIn(duration: 500.ms),

                                const SizedBox(height: AppSpacing.xxl),
                                const Divider(),
                                const SizedBox(height: AppSpacing.xxl),

                                // Technologies
                                _DetailSection(
                                  title: 'Technologies Used',
                                  isDark: isDark,
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: project.technologies
                                        .map((t) => TechnologyChip(
                                              label: t,
                                              isDark: isDark,
                                            ))
                                        .toList(),
                                  ),
                                ),

                                // Overview
                                const SizedBox(height: AppSpacing.xl),
                                _DetailSection(
                                  title: 'Overview',
                                  isDark: isDark,
                                  child: Text(
                                    project.description,
                                    style: AppTextStyles.bodyLg(isDark: isDark),
                                  ),
                                ),

                                // Problem + Solution
                                if (project.problem != null || project.solution != null) ...[
                                  const SizedBox(height: AppSpacing.xl),
                                  if (!isMobile)
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (project.problem != null)
                                          Expanded(
                                            child: _DetailSection(
                                              title: '🎯 The Problem',
                                              isDark: isDark,
                                              child: Text(project.problem!,
                                                  style: AppTextStyles.bodyMd(isDark: isDark)),
                                            ),
                                          ),
                                        if (project.problem != null && project.solution != null)
                                          const SizedBox(width: AppSpacing.xl),
                                        if (project.solution != null)
                                          Expanded(
                                            child: _DetailSection(
                                              title: '💡 The Solution',
                                              isDark: isDark,
                                              child: Text(project.solution!,
                                                  style: AppTextStyles.bodyMd(isDark: isDark)),
                                            ),
                                          ),
                                      ],
                                    )
                                  else
                                    Column(
                                      children: [
                                        if (project.problem != null)
                                          _DetailSection(
                                            title: '🎯 The Problem',
                                            isDark: isDark,
                                            child: Text(project.problem!,
                                                style: AppTextStyles.bodyMd(isDark: isDark)),
                                          ),
                                        if (project.solution != null) ...[
                                          const SizedBox(height: AppSpacing.xl),
                                          _DetailSection(
                                            title: '💡 The Solution',
                                            isDark: isDark,
                                            child: Text(project.solution!,
                                                style: AppTextStyles.bodyMd(isDark: isDark)),
                                          ),
                                        ],
                                      ],
                                    ),
                                ],

                                // Key Features
                                if (project.features.isNotEmpty) ...[
                                  const SizedBox(height: AppSpacing.xl),
                                  _DetailSection(
                                    title: 'Key Features',
                                    isDark: isDark,
                                    child: Column(
                                      children: project.features
                                          .map(
                                            (f) => Padding(
                                              padding: const EdgeInsets.only(bottom: 8),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.check_circle_outline_rounded,
                                                      size: 18,
                                                      color: AppColors.teal),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(f,
                                                        style: AppTextStyles.bodyMd(isDark: isDark)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],

                                // Results
                                if (project.results != null) ...[
                                  const SizedBox(height: AppSpacing.xl),
                                  _DetailSection(
                                    title: '📈 Results & Impact',
                                    isDark: isDark,
                                    child: Container(
                                      padding: const EdgeInsets.all(AppSpacing.lg),
                                      decoration: BoxDecoration(
                                        color: AppColors.teal.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: AppColors.teal.withOpacity(0.2)),
                                      ),
                                      child: Text(
                                        project.results!,
                                        style: AppTextStyles.bodyMd(isDark: isDark),
                                      ),
                                    ),
                                  ),
                                ],

                                const SizedBox(height: AppSpacing.xxxl),
                              ],
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

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.isDark,
    required this.child,
  });

  final String title;
  final bool isDark;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headingMd(isDark: isDark)),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    );
  }
}
