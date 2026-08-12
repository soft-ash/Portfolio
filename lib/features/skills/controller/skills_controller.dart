import 'package:get/get.dart';
import '../../../data/models/skill_model.dart';
import '../../../core/repository/skills_repository.dart';

class SkillsController extends GetxController {
  final SkillsRepository _repository = Get.find<SkillsRepository>();

  final RxList<SkillModel> skills = <SkillModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<String> error = Rxn();
  final Rx<SkillCategory?> selectedCategory = Rx(null);

  List<SkillModel> get filteredSkills => selectedCategory.value == null
      ? skills
      : skills.where((s) => s.category == selectedCategory.value).toList();

  List<SkillCategory> get categories =>
      SkillCategory.values.where((c) => skills.any((s) => s.category == c)).toList();

  @override
  void onInit() {
    super.onInit();
    loadSkills();
  }

  Future<void> loadSkills() async {
    isLoading.value = true;
    error.value = null;
    try {
      final data = await _repository.getSkills();
      skills.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(SkillCategory? category) {
    selectedCategory.value = category;
  }
}
