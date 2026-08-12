import 'package:get/get.dart';
import '../../../data/models/certification_model.dart';
import '../../../core/repository/certification_repository.dart';

class CertificationsController extends GetxController {
  final CertificationRepository _repository = Get.find<CertificationRepository>();
  final RxList<CertificationModel> certifications = <CertificationModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    try {
      certifications.assignAll(await _repository.getCertifications());
    } finally {
      isLoading.value = false;
    }
  }
}
