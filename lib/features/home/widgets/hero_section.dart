import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../app/constants/profile_constants.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/responsive/screen_size.dart';
import '../../../core/utils/theme_controller.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/buttons.dart';
import 'particles_background.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HERO SECTION
// ─────────────────────────────────────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  final VoidCallback onViewWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDark.value;
    final isMobile = ScreenSize.isMobile(context);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          // Animated background
          const Positioned.fill(child: ParticlesBackground()),

          // Background gradient
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.3, -0.3),
                  radius: 1.2,
                  colors: [
                    AppColors.accent.withOpacity(0.08),
                    Colors.transparent,
                    AppColors.teal.withOpacity(0.04),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
              ),
              child: isMobile
                  ? _MobileHero(onViewWork: onViewWork, onContact: onContact, isDark: isDark)
                  : _DesktopHero(onViewWork: onViewWork, onContact: onContact, isDark: isDark),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: _ScrollIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  const _DesktopHero({
    required this.onViewWork,
    required this.onContact,
    required this.isDark,
  });

  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Row(
        children: [
          // Left side — content
          Expanded(
            flex: 6,
            child: _HeroContent(
              onViewWork: onViewWork,
              onContact: onContact,
              isDark: isDark,
            ),
          ),

          const SizedBox(width: AppSpacing.xxl),

          // Right side — avatar
          Expanded(
            flex: 4,
            child: _HeroAvatar(isDark: isDark),
          ),
        ],
      ),
    );
  }
}

class _MobileHero extends StatelessWidget {
  const _MobileHero({
    required this.onViewWork,
    required this.onContact,
    required this.isDark,
  });

  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _HeroAvatar(isDark: isDark, isMobile: true),
          const SizedBox(height: AppSpacing.xl),
          _HeroContent(
            onViewWork: onViewWork,
            onContact: onContact,
            isDark: isDark,
            isMobile: true,
          ),
        ],
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.onViewWork,
    required this.onContact,
    required this.isDark,
    this.isMobile = false,
  });

  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final bool isDark;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal.withOpacity(0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for opportunities',
                style: AppTextStyles.labelMd(isDark: isDark)
                    .copyWith(color: AppColors.teal, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),

        const SizedBox(height: AppSpacing.lg),

        // Name
        Text(
          'Hi, I\'m',
          style: AppTextStyles.headingMd(isDark: isDark)
              .copyWith(color: AppColors.darkTextSecondary),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        )
            .animate(delay: 100.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),

        const SizedBox(height: AppSpacing.sm),

        ShaderMask(
          shaderCallback: (bounds) => AppColors.accentGradient.createShader(bounds),
          child: Text(
            ProfileConstants.fullName,
            style: AppTextStyles.displayMedium(isDark: true)
                .copyWith(color: Colors.white),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        )
            .animate(delay: 200.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),

        const SizedBox(height: AppSpacing.md),

        // Title with typewriter-style color
        Text(
          ProfileConstants.title,
          style: AppTextStyles.headingLg(isDark: isDark)
              .copyWith(color: AppColors.darkTextSecondary),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        )
            .animate(delay: 300.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),

        const SizedBox(height: AppSpacing.lg),

        // Bio
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 520),
          child: Text(
            ProfileConstants.bio,
            style: AppTextStyles.bodyLg(isDark: isDark),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),

        const SizedBox(height: AppSpacing.xxl),

        // CTAs
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PrimaryButton(
              label: 'View My Work',
              onTap: onViewWork,
              icon: Icons.arrow_downward_rounded,
            ),
            SecondaryButton(
              label: 'Download CV',
              onTap: () => UrlLauncherUtil.launch(ProfileConstants.resumeUrl),
              icon: Icons.download_rounded,
              isDark: isDark,
            ),
          ],
        )
            .animate(delay: 500.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),

        const SizedBox(height: AppSpacing.xl),

        // Social links
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _SocialButton(
              icon: Icons.code,
              label: 'GitHub',
              url: ProfileConstants.githubUrl,
              isDark: isDark,
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: Icons.work_outline_rounded,
              label: 'LinkedIn',
              url: ProfileConstants.linkedinUrl,
              isDark: isDark,
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: Icons.email_outlined,
              label: 'Email',
              url: 'mailto:${ProfileConstants.email}',
              isDark: isDark,
            ),
          ],
        )
            .animate(delay: 600.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms),
      ],
    );
  }
}

class _HeroAvatar extends StatefulWidget {
  const _HeroAvatar({required this.isDark, this.isMobile = false});
  final bool isDark;
  final bool isMobile;

  @override
  State<_HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<_HeroAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.isMobile ? 180.0 : 320.0;

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: size + 40,
              height: size + 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    AppColors.accent.withOpacity(0.3),
                    AppColors.teal.withOpacity(0.3),
                    AppColors.accent.withOpacity(0.1),
                    AppColors.accent.withOpacity(0.3),
                  ],
                ),
              ),
            ),

            // Inner background circle
            Container(
              width: size + 16,
              height: size + 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkSurface,
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
            ),

            // Profile image
            ClipOval(
              child: Image.asset(
                ProfileConstants.profileImagePath,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: size,
                  height: size,
                  color: AppColors.darkSurface,
                  child: Icon(
                    Icons.person_rounded,
                    size: size * 0.5,
                    color: AppColors.accent.withOpacity(0.5),
                  ),
                ),
              ),
            ),

            // Floating tech badges
            if (!widget.isMobile) ...[
              Positioned(
                top: 20,
                right: -10,
                child: _TechBadge(label: 'Flutter', color: AppColors.accent),
              ),
              Positioned(
                bottom: 40,
                left: -10,
                child: _TechBadge(label: 'AI / ML', color: AppColors.teal),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: _TechBadge(label: 'GetX', color: AppColors.rose),
              ),
            ],
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 800.ms, delay: 400.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 800.ms),
    );
  }
}

class _TechBadge extends StatelessWidget {
  const _TechBadge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String url;
  final bool isDark;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtil.launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withOpacity(0.1)
                : (widget.isDark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.darkBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? AppColors.accent : AppColors.darkTextSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTextStyles.labelMd(isDark: widget.isDark).copyWith(
                  color: _hovered ? AppColors.accent : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 1.0 - (_controller.value * 0.5),
          child: Transform.translate(
            offset: Offset(0, _controller.value * 8),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.accent.withOpacity(0.6),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            'Scroll to explore',
            style: AppTextStyles.labelSm().copyWith(
              color: AppColors.darkTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}
