import 'package:test_task/core/domain/entities/entities.dart';
import 'package:test_task/core/domain/repositories/repositories.dart';
import 'package:test_task/core/data/mappers/mappers.dart';
import 'package:test_task/core/data/sources/services/service_source.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl({required ServiceSource serviceSource}) : _serviceSource = serviceSource;

  final ServiceSource _serviceSource;

  @override
  Future<List<ServiceEntity>> getAllServices() async {
    final entities = await _serviceSource.getAllServices();
    return entities.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ServiceEntity> updateService({required int id, required int days}) async {
    // Некоторая зедержка для примера покупки

   await  Future.delayed(Duration(seconds: 5));
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final newSubDateMs = nowMs + _convertDaysToMs(days);

    final updatedEntity = await _serviceSource.updateService(id: id, subDateMs: newSubDateMs);

    return updatedEntity.toEntity();
  }

  // ------------------------------------- helpers -----------------------------------------

  int _convertDaysToMs(int days) {
    const msPerDay = 24 * 60 * 60 * 1000;
    return msPerDay * days;
  }
}
