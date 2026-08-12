import '../../data/models/education_model.dart';
import '../../data/local/local_data_source.dart';

abstract class EducationRepository {
  Future<List<EducationModel>> getEducation();
}

class LocalEducationRepository implements EducationRepository {
  @override
  Future<List<EducationModel>> getEducation() async =>
      LocalDataSource.getEducation();
}
