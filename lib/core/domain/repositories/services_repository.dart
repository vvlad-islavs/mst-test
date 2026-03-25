import 'package:test_task/core/domain/entities/entities.dart';

abstract class ServicesRepository {
  Future<List<ServiceEntity>> getAllServices();

  /// Updates subscription end date for a service by adding [days] from `DateTime.now()`.
  Future<ServiceEntity> updateService({
    required int id,
    required int days,
  });
}

