import '../../data/models/skill_model.dart';
import '../../data/local/local_data_source.dart';

abstract class SkillsRepository {
  Future<List<SkillModel>> getSkills();
  Future<List<SkillModel>> getSkillsByCategory(SkillCategory category);
}

class LocalSkillsRepository implements SkillsRepository {
  @override
  Future<List<SkillModel>> getSkills() async =>
      LocalDataSource.getSkills();

  @override
  Future<List<SkillModel>> getSkillsByCategory(SkillCategory category) async =>
      LocalDataSource.getSkills().where((s) => s.category == category).toList();
}
