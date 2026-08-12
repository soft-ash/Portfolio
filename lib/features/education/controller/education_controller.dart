import 'package:get/get.dart';
import '../../../data/models/education_model.dart';
import '../../../core/repository/education_repository.dart';

class EducationController extends GetxController {
  final EducationRepository _repository = Get.find<EducationRepository>();
  final RxList<EducationModel> education = <EducationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    try {
      education.assignAll(await _repository.getEducation());
    } finally {
      isLoading.value = false;
    }
  }
}
