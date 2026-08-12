import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOME CONTROLLER
// Manages the main scroll behavior and active section state
// ─────────────────────────────────────────────────────────────────────────────

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxInt activeSection = 0.obs;
  final RxBool navBarScrolled = false.obs;
  final RxBool mobileMenuOpen = false.obs;

  // Section global keys for scroll navigation
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final experienceKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final certificationsKey = GlobalKey();
  final servicesKey = GlobalKey();
  final blogKey = GlobalKey();
  final contactKey = GlobalKey();

  List<GlobalKey> get sectionKeys => [
        heroKey,
        aboutKey,
        experienceKey,
        skillsKey,
        projectsKey,
        educationKey,
        certificationsKey,
        servicesKey,
        blogKey,
        contactKey,
      ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    navBarScrolled.value = scrollController.offset > 60;
  }

  void scrollToSection(int index) {
    activeSection.value = index;
    final key = sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
    // Close mobile menu if open
    mobileMenuOpen.value = false;
  }

  void scrollToTop() => scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );

  void toggleMobileMenu() => mobileMenuOpen.value = !mobileMenuOpen.value;

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
