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
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/animated_section.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/section_header.dart';
import '../controller/contact_controller.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
                  label: 'Contact',
                  title: 'Let\'s work together',
                  subtitle: 'Have a project in mind? Looking for a collaborator? Or just want to say hi? Drop me a message!',
                  isDark: isDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              AnimatedSection(
                child: isMobile
                    ? _MobileContactLayout(isDark: isDark)
                    : _DesktopContactLayout(isDark: isDark),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _DesktopContactLayout extends StatelessWidget {
  const _DesktopContactLayout({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _ContactInfo(isDark: isDark)),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(flex: 3, child: _ContactForm(isDark: isDark)),
      ],
    );
  }
}

class _MobileContactLayout extends StatelessWidget {
  const _MobileContactLayout({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactInfo(isDark: isDark),
        const SizedBox(height: AppSpacing.xxl),
        _ContactForm(isDark: isDark),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Get in touch', style: AppTextStyles.headingLg(isDark: isDark)),
        const SizedBox(height: AppSpacing.md),
        Text(
          'I\'m currently open to new opportunities. Whether you need a Flutter developer, '
          'want to discuss a project, or just want to connect — my inbox is always open.',
          style: AppTextStyles.bodyMd(isDark: isDark),
        ),
        const SizedBox(height: AppSpacing.xxl),

        _ContactLink(
          icon: Icons.email_outlined,
          label: 'Email',
          value: ProfileConstants.email,
          onTap: () => UrlLauncherUtil.launchEmail(ProfileConstants.email),
          isDark: isDark,
        ),
        const SizedBox(height: AppSpacing.md),
        _ContactLink(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: ProfileConstants.location,
          onTap: null,
          isDark: isDark,
        ),
        const SizedBox(height: AppSpacing.md),
        _ContactLink(
          icon: Icons.code,
          label: 'GitHub',
          value: ProfileConstants.githubUrl.replaceFirst('https://', ''),
          onTap: () => UrlLauncherUtil.launch(ProfileConstants.githubUrl),
          isDark: isDark,
        ),
        const SizedBox(height: AppSpacing.md),
        _ContactLink(
          icon: Icons.work_outline_rounded,
          label: 'LinkedIn',
          value: ProfileConstants.linkedinUrl.replaceFirst('https://', ''),
          onTap: () => UrlLauncherUtil.launch(ProfileConstants.linkedinUrl),
          isDark: isDark,
        ),
      ],
    );
  }
}

class _ContactLink extends StatefulWidget {
  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    required this.isDark,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool isDark;

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _hovered ? AppColors.accent.withOpacity(0.1) : AppColors.darkBorder.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _hovered ? AppColors.accent.withOpacity(0.4) : AppColors.darkBorder,
                ),
              ),
              child: Icon(widget.icon,
                  size: 18,
                  color: _hovered ? AppColors.accent : AppColors.darkTextSecondary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.label, style: AppTextStyles.labelSm(isDark: widget.isDark)),
                  Text(
                    widget.value,
                    style: AppTextStyles.bodyMd(isDark: widget.isDark).copyWith(
                      color: _hovered ? AppColors.accent : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();

    return Obx(() {
      if (controller.status.value == ContactStatus.success) {
        return _SuccessState(isDark: isDark, onReset: controller.resetStatus);
      }

      return Container(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Send a message', style: AppTextStyles.headingMd(isDark: isDark)),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: _FormField(
                      controller: controller.nameController,
                      label: 'Your Name',
                      validator: controller.validateName,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _FormField(
                      controller: controller.emailController,
                      label: 'Email Address',
                      validator: controller.validateEmail,
                      isDark: isDark,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _FormField(
                controller: controller.subjectController,
                label: 'Subject',
                validator: controller.validateSubject,
                isDark: isDark,
              ),
              const SizedBox(height: AppSpacing.md),
              _FormField(
                controller: controller.messageController,
                label: 'Message',
                validator: controller.validateMessage,
                isDark: isDark,
                maxLines: 5,
                minLines: 5,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (controller.status.value == ContactStatus.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Text(
                    controller.errorMessage.value ?? 'Something went wrong.',
                    style: AppTextStyles.bodyMd()
                        .copyWith(color: AppColors.error),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Send Message',
                  onTap: controller.sendMessage,
                  icon: Icons.send_rounded,
                  isLoading: controller.status.value == ContactStatus.loading,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.label,
    this.validator,
    required this.isDark,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isDark;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      style: AppTextStyles.bodyMd(isDark: isDark),
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: (minLines ?? 1) > 1,
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.isDark, required this.onReset});
  final bool isDark;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.teal.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.teal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_outline_rounded,
                size: 36, color: AppColors.teal),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Message Sent!', style: AppTextStyles.headingMd(isDark: isDark)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Thank you for reaching out. I\'ll get back to you as soon as possible!',
            style: AppTextStyles.bodyMd(isDark: isDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          SecondaryButton(
            label: 'Send Another',
            onTap: onReset,
            isDark: isDark,
          ),
        ],
      ),
    )
        .animate()
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 400.ms)
        .fadeIn(duration: 400.ms);
  }
}
