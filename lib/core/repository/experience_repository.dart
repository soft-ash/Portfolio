import '../../data/models/experience_model.dart';
import '../../data/local/local_data_source.dart';

abstract class ExperienceRepository {
  Future<List<ExperienceModel>> getExperiences();
}

class LocalExperienceRepository implements ExperienceRepository {
  @override
  Future<List<ExperienceModel>> getExperiences() async =>
      LocalDataSource.getExperiences();
}
