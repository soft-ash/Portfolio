import 'dart:ui' as ui;
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
import '../../../core/widgets/buttons.dart';
import '../controller/home_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CUSTOM NAV BAR — Sticky top navigation with desktop & mobile variants
// ─────────────────────────────────────────────────────────────────────────────

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.navBarHeight);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final homeController = Get.find<HomeController>();
      final scrolled = homeController.navBarScrolled.value;
      final isMobile = ScreenSize.isMobile(context);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: AppConstants.navBarHeight,
        decoration: BoxDecoration(
          color: scrolled
              ? (isDark
                  ? AppColors.darkBackground.withOpacity(0.92)
                  : AppColors.lightBackground.withOpacity(0.95))
              : Colors.transparent,
          border: scrolled
              ? Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 1,
                  ),
                )
              : null,
          boxShadow: scrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: scrolled
                ? ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12)
                : ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
              ),
              child: Row(
                children: [
                  // Logo / Name
                  GestureDetector(
                    onTap: homeController.scrollToTop,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SvgPicture.asset(
                        ProfileConstants.logoImagePath,
                        height: 32,
                        placeholderBuilder: (context) => ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.accentGradient.createShader(bounds),
                          child: Text(
                            ProfileConstants.name,
                            style: AppTextStyles.headingMd(isDark: true).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  if (!isMobile) ...[
                    // Desktop nav items
                    ...AppConstants.navItems.map((item) {
                      final isActive = homeController.activeSection.value ==
                          item['section'];
                      return _NavItem(
                        label: item['label'] as String,
                        isActive: isActive,
                        isDark: isDark,
                        onTap: () => homeController
                            .scrollToSection(item['section'] as int),
                      );
                    }),

                    const SizedBox(width: AppSpacing.md),

                    // Theme switcher
                    _ThemeSwitcher(isDark: isDark),

                    const SizedBox(width: AppSpacing.md),

                    // Resume button
                    PrimaryButton(
                      label: 'Resume',
                      onTap: () => UrlLauncherUtil.launch(ProfileConstants.resumeUrl),
                      icon: Icons.download_rounded,
                      small: true,
                    ),
                  ] else ...[
                    // Mobile: theme switcher + hamburger
                    _ThemeSwitcher(isDark: isDark),
                    const SizedBox(width: AppSpacing.sm),
                    _HamburgerButton(isDark: isDark),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}


class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: widget.isActive
                    ? AppTextStyles.navItemActive(isDark: widget.isDark)
                    : AppTextStyles.navItem(isDark: widget.isDark).copyWith(
                        color: _hovered
                            ? (widget.isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.lightTextPrimary)
                            : null,
                      ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : (_hovered ? 10 : 0),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeSwitcher extends StatelessWidget {
  const _ThemeSwitcher({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.find<ThemeController>().toggleTheme,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            size: 18,
            color: isDark ? AppColors.amber : AppColors.darkTextSecondary,
          ),
        ),
      ),
    );
  }
}

class _HamburgerButton extends StatelessWidget {
  const _HamburgerButton({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final homeController = Get.find<HomeController>();
      final isOpen = homeController.mobileMenuOpen.value;

      return GestureDetector(
        onTap: homeController.toggleMobileMenu,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isOpen ? Icons.close_rounded : Icons.menu_rounded,
                key: ValueKey(isOpen),
                size: 20,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MOBILE DRAWER / SLIDE-IN MENU
// ─────────────────────────────────────────────────────────────────────────────

class MobileNavMenu extends StatelessWidget {
  const MobileNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;
      final homeController = Get.find<HomeController>();
      final isOpen = homeController.mobileMenuOpen.value;

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        top: AppConstants.navBarHeight,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          opacity: isOpen ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: IgnorePointer(
            ignoring: !isOpen,
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkBackground.withOpacity(0.97)
                    : AppColors.lightBackground.withOpacity(0.97),
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...AppConstants.navItems.map((item) => _MobileNavItem(
                        label: item['label'] as String,
                        isDark: isDark,
                        onTap: () =>
                            homeController.scrollToSection(item['section'] as int),
                      )),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Download Resume',
                    onTap: () {
                      homeController.mobileMenuOpen.value = false;
                      UrlLauncherUtil.launch(ProfileConstants.resumeUrl);
                    },
                    icon: Icons.download_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  final String label;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Text(
          label,
          style: AppTextStyles.headingSm(isDark: isDark),
        ),
      ),
    );
  }
}
