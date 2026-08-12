import '../../data/models/project_model.dart';
import '../../data/local/local_data_source.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT REPOSITORY
// Abstract contract + local implementation.
// Replace LocalProjectRepository with RemoteProjectRepository to use API.
// ─────────────────────────────────────────────────────────────────────────────

abstract class ProjectRepository {
  Future<List<ProjectModel>> getProjects();
  Future<List<ProjectModel>> getFeaturedProjects();
  Future<ProjectModel?> getProjectById(String id);
  Future<List<ProjectModel>> getProjectsByCategory(String category);
}

class LocalProjectRepository implements ProjectRepository {
  @override
  Future<List<ProjectModel>> getProjects() async =>
      LocalDataSource.getProjects();

  @override
  Future<List<ProjectModel>> getFeaturedProjects() async =>
      LocalDataSource.getProjects().where((p) => p.featured).toList();

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    try {
      return LocalDataSource.getProjects().firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ProjectModel>> getProjectsByCategory(String category) async =>
      LocalDataSource.getProjects()
          .where((p) => p.category == category)
          .toList();
}
