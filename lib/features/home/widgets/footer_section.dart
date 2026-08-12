import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/constants/profile_constants.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../controller/home_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FOOTER SECTION
// ─────────────────────────────────────────────────────────────────────────────

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final homeController = Get.find<HomeController>();
      final isMobile = ScreenSize.isMobile(context);

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
          vertical: AppSpacing.xxl,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? _MobileFooter(isDark: isDark, homeController: homeController)
              : _DesktopFooter(isDark: isDark, homeController: homeController),
        ),
      );
    });
  }
}

class _DesktopFooter extends StatelessWidget {
  const _DesktopFooter({required this.isDark, required this.homeController});
  final bool isDark;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    ProfileConstants.logoImagePath,
                    height: 48,
                    alignment: Alignment.centerLeft,
                    placeholderBuilder: (context) => ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.accentGradient.createShader(bounds),
                      child: Text(
                        ProfileConstants.fullName,
                        style: AppTextStyles.headingLg(isDark: true)
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    ProfileConstants.title,
                    style: AppTextStyles.bodyMd(isDark: isDark),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    ProfileConstants.shortBio,
                    style: AppTextStyles.bodySm(isDark: isDark),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.xxl),

            // Quick nav
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Navigation', style: AppTextStyles.labelLg(isDark: isDark)),
                  const SizedBox(height: AppSpacing.md),
                  ...AppConstants.navItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _FooterLink(
                          label: item['label'] as String,
                          onTap: () =>
                              homeController.scrollToSection(item['section'] as int),
                          isDark: isDark,
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.xxl),

            // Contact
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Connect', style: AppTextStyles.labelLg(isDark: isDark)),
                  const SizedBox(height: AppSpacing.md),
                  _FooterLink(
                    label: 'GitHub',
                    onTap: () => UrlLauncherUtil.launch(ProfileConstants.githubUrl),
                    isDark: isDark,
                    icon: Icons.code,
                  ),
                  const SizedBox(height: 8),
                  _FooterLink(
                    label: 'LinkedIn',
                    onTap: () => UrlLauncherUtil.launch(ProfileConstants.linkedinUrl),
                    isDark: isDark,
                    icon: Icons.work_outline_rounded,
                  ),
                  const SizedBox(height: 8),
                  _FooterLink(
                    label: ProfileConstants.email,
                    onTap: () => UrlLauncherUtil.launchEmail(ProfileConstants.email),
                    isDark: isDark,
                    icon: Icons.email_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),
        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        const SizedBox(height: AppSpacing.md),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '© ${DateTime.now().year} ${ProfileConstants.fullName}. All rights reserved.',
              style: AppTextStyles.labelSm(isDark: isDark),
            ),
            Text(
              'Built with Flutter ❤️',
              style: AppTextStyles.labelSm(isDark: isDark)
                  .copyWith(color: AppColors.accent),
            ),
          ],
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  const _MobileFooter({required this.isDark, required this.homeController});
  final bool isDark;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Brand
        SvgPicture.asset(
          ProfileConstants.logoImagePath,
          height: 48,
          placeholderBuilder: (context) => ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.accentGradient.createShader(bounds),
            child: Text(
              ProfileConstants.fullName,
              style: AppTextStyles.headingLg(isDark: true)
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          ProfileConstants.shortBio,
          style: AppTextStyles.bodySm(isDark: isDark),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),

        // Social buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => UrlLauncherUtil.launch(ProfileConstants.githubUrl),
              icon: const Icon(Icons.code),
              color: AppColors.darkTextSecondary,
            ),
            IconButton(
              onPressed: () => UrlLauncherUtil.launch(ProfileConstants.linkedinUrl),
              icon: const Icon(Icons.work_outline_rounded),
              color: AppColors.darkTextSecondary,
            ),
            IconButton(
              onPressed: () => UrlLauncherUtil.launchEmail(ProfileConstants.email),
              icon: const Icon(Icons.email_outlined),
              color: AppColors.darkTextSecondary,
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),
        Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        const SizedBox(height: AppSpacing.md),

        Text(
          '© ${DateTime.now().year} ${ProfileConstants.fullName}',
          style: AppTextStyles.labelSm(isDark: isDark),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'Built with Flutter ❤️',
          style: AppTextStyles.labelSm(isDark: isDark)
              .copyWith(color: AppColors.accent),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({
    required this.label,
    required this.onTap,
    required this.isDark,
    this.icon,
  });

  final String label;
  final VoidCallback onTap;
  final bool isDark;
  final IconData? icon;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 14,
                color: _hovered ? AppColors.accent : AppColors.darkTextMuted,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              widget.label,
              style: AppTextStyles.bodyMd(isDark: widget.isDark).copyWith(
                color: _hovered ? AppColors.accent : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
