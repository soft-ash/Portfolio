import 'package:get/get.dart';
import '../../../data/models/service_model.dart';
import '../../../core/repository/service_repository.dart';

class ServicesController extends GetxController {
  final ServiceRepository _repository = Get.find<ServiceRepository>();
  final RxList<ServiceModel> services = <ServiceModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    try {
      services.assignAll(await _repository.getServices());
    } finally {
      isLoading.value = false;
    }
  }
}
