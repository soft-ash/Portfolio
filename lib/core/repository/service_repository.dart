import '../../data/models/service_model.dart';
import '../../data/local/local_data_source.dart';

abstract class ServiceRepository {
  Future<List<ServiceModel>> getServices();
}

class LocalServiceRepository implements ServiceRepository {
  @override
  Future<List<ServiceModel>> getServices() async =>
      LocalDataSource.getServices();
}
