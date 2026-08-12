import '../../data/models/certification_model.dart';
import '../../data/local/local_data_source.dart';

abstract class CertificationRepository {
  Future<List<CertificationModel>> getCertifications();
}

class LocalCertificationRepository implements CertificationRepository {
  @override
  Future<List<CertificationModel>> getCertifications() async =>
      LocalDataSource.getCertifications();
}
