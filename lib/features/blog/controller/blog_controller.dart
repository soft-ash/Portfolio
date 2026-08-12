import 'package:get/get.dart';
import '../../../data/models/blog_model.dart';
import '../../../core/repository/blog_repository.dart';

class BlogController extends GetxController {
  final BlogRepository _repository = Get.find<BlogRepository>();
  final RxList<BlogModel> posts = <BlogModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    try {
      posts.assignAll(await _repository.getBlogPosts());
    } finally {
      isLoading.value = false;
    }
  }
}
