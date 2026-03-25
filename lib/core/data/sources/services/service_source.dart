import 'package:test_task/core/data/db/db.dart';

abstract class ServiceSource {
  Future<List<ServiceDto>> getAllServices();

  /// Updates service by id and sets subscription end date to [subDateMs].
  Future<ServiceDto> updateService({
    required int id,
    required int subDateMs,
  });
}

