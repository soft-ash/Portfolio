import 'package:get/get.dart';
import '../../../core/repository/project_repository.dart';
import '../../projects/controller/projects_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectRepository>(() => LocalProjectRepository());
    Get.lazyPut(() => ProjectsController());
  }
}
