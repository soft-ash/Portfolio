import '../../data/models/blog_model.dart';
import '../../data/local/local_data_source.dart';

abstract class BlogRepository {
  Future<List<BlogModel>> getBlogPosts();
  Future<BlogModel?> getBlogBySlug(String slug);
}

class LocalBlogRepository implements BlogRepository {
  @override
  Future<List<BlogModel>> getBlogPosts() async =>
      LocalDataSource.getBlogPosts();

  @override
  Future<BlogModel?> getBlogBySlug(String slug) async {
    try {
      return LocalDataSource.getBlogPosts().firstWhere((b) => b.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
