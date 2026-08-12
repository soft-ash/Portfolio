import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/utils/theme_controller.dart';
import '../../about/screen/about_section.dart';
import '../../blog/screen/blog_section.dart';
import '../../certifications/screen/certifications_section.dart';
import '../../contact/screen/contact_section.dart';
import '../../education/screen/education_section.dart';
import '../../experience/screen/experience_section.dart';
import '../../projects/screen/projects_section.dart';
import '../../services/screen/services_section.dart';
import '../../skills/screen/skills_section.dart';
import '../controller/home_controller.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOME SCREEN — Single page scrollable shell
// All sections are rendered as a single scrollable list.
// Navigation scrolls to the corresponding section key.
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      final isDark = Get.find<ThemeController>().isDark.value;

      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        extendBodyBehindAppBar: true,
        appBar: const CustomNavBar(),
        body: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              controller: homeController.scrollController,
              child: Column(
                children: [
                  // Hero
                  KeyedSubtree(
                    key: homeController.heroKey,
                    child: HeroSection(
                      onViewWork: () => homeController.scrollToSection(4),
                      onContact: () => homeController.scrollToSection(9),
                    ),
                  ),

                  // About
                  KeyedSubtree(
                    key: homeController.aboutKey,
                    child: const AboutSection(),
                  ),

                  // Experience
                  KeyedSubtree(
                    key: homeController.experienceKey,
                    child: const ExperienceSection(),
                  ),

                  // Skills
                  KeyedSubtree(
                    key: homeController.skillsKey,
                    child: const SkillsSection(),
                  ),

                  // Projects
                  KeyedSubtree(
                    key: homeController.projectsKey,
                    child: const ProjectsSection(),
                  ),

                  // Education
                  KeyedSubtree(
                    key: homeController.educationKey,
                    child: const EducationSection(),
                  ),

                  // Certifications
                  KeyedSubtree(
                    key: homeController.certificationsKey,
                    child: const CertificationsSection(),
                  ),

                  // Services
                  KeyedSubtree(
                    key: homeController.servicesKey,
                    child: const ServicesSection(),
                  ),

                  // Blog
                  KeyedSubtree(
                    key: homeController.blogKey,
                    child: const BlogSection(),
                  ),

                  // Contact
                  KeyedSubtree(
                    key: homeController.contactKey,
                    child: const ContactSection(),
                  ),

                  // Footer
                  const FooterSection(),
                ],
              ),
            ),

            // Mobile slide-in menu (positioned on top)
            const MobileNavMenu(),
          ],
        ),
      );
    });
  }
}
