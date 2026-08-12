import 'package:get/get.dart';
import '../../features/home/screen/home_screen.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/projects/screen/project_detail_screen.dart';
import '../../features/projects/bindings/project_binding.dart';
import 'app_routes.dart';

// ─────────────────────────────────────────────────────────────────────────────
// GETX PAGES — ROUTE DEFINITIONS
// ─────────────────────────────────────────────────────────────────────────────

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.projectDetail,
      page: () => const ProjectDetailScreen(),
      binding: ProjectBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
