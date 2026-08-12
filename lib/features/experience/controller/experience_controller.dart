import 'package:get/get.dart';
import '../../../data/models/experience_model.dart';
import '../../../core/repository/experience_repository.dart';

class ExperienceController extends GetxController {
  final ExperienceRepository _repository = Get.find<ExperienceRepository>();

  final RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rxn<String> error = Rxn();

  @override
  void onInit() {
    super.onInit();
    loadExperiences();
  }

  Future<void> loadExperiences() async {
    isLoading.value = true;
    error.value = null;
    try {
      final data = await _repository.getExperiences();
      experiences.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
