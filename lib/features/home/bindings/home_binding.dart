import 'package:get/get.dart';
import '../../../core/repository/project_repository.dart';
import '../../../core/repository/experience_repository.dart';
import '../../../core/repository/skills_repository.dart';
import '../../../core/repository/education_repository.dart';
import '../../../core/repository/certification_repository.dart';
import '../../../core/repository/service_repository.dart';
import '../../../core/repository/blog_repository.dart';
import '../../../core/repository/contact_repository.dart';
import '../controller/home_controller.dart';
import '../../experience/controller/experience_controller.dart';
import '../../skills/controller/skills_controller.dart';
import '../../projects/controller/projects_controller.dart';
import '../../education/controller/education_controller.dart';
import '../../certifications/controller/certifications_controller.dart';
import '../../services/controller/services_controller.dart';
import '../../blog/controller/blog_controller.dart';
import '../../contact/controller/contact_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOME BINDING — Dependency injection for the home screen
// ─────────────────────────────────────────────────────────────────────────────

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Repositories
    Get.lazyPut<ProjectRepository>(() => LocalProjectRepository());
    Get.lazyPut<ExperienceRepository>(() => LocalExperienceRepository());
    Get.lazyPut<SkillsRepository>(() => LocalSkillsRepository());
    Get.lazyPut<EducationRepository>(() => LocalEducationRepository());
    Get.lazyPut<CertificationRepository>(() => LocalCertificationRepository());
    Get.lazyPut<ServiceRepository>(() => LocalServiceRepository());
    Get.lazyPut<BlogRepository>(() => LocalBlogRepository());
    Get.lazyPut<ContactRepository>(() => LocalContactRepository());

    // Controllers
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ExperienceController());
    Get.lazyPut(() => SkillsController());
    Get.lazyPut(() => ProjectsController());
    Get.lazyPut(() => EducationController());
    Get.lazyPut(() => CertificationsController());
    Get.lazyPut(() => ServicesController());
    Get.lazyPut(() => BlogController());
    Get.lazyPut(() => ContactController());
  }
}
