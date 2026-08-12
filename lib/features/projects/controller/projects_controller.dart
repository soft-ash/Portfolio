import 'package:get/get.dart';
import '../../../data/models/project_model.dart';
import '../../../core/repository/project_repository.dart';

class ProjectsController extends GetxController {
  final ProjectRepository _repository = Get.find<ProjectRepository>();

  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxList<ProjectModel> featuredProjects = <ProjectModel>[].obs;
  final Rxn<ProjectModel> selectedProject = Rxn();
  final RxBool isLoading = false.obs;
  final Rxn<String> error = Rxn();
  final RxString selectedCategory = 'All'.obs;

  List<String> get categories {
    final cats = projects.map((p) => p.category).toSet().toList()..sort();
    return ['All', ...cats];
  }

  List<ProjectModel> get filteredProjects => selectedCategory.value == 'All'
      ? projects
      : projects.where((p) => p.category == selectedCategory.value).toList();

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  Future<void> loadProjects() async {
    isLoading.value = true;
    error.value = null;
    try {
      final all = await _repository.getProjects();
      projects.assignAll(all);
      featuredProjects.assignAll(all.where((p) => p.featured).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadProjectById(String id) async {
    isLoading.value = true;
    try {
      selectedProject.value = await _repository.getProjectById(id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }
}
