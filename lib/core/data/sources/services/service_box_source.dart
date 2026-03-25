import 'package:test_task/core/data/db/db.dart';
import 'package:test_task/core/data/sources/services/service_source.dart';

class ServiceBoxSource implements ServiceSource {
  ServiceBoxSource({required this.objectBox});

  final ObjectBoxStore objectBox;

  @override
  Future<List<ServiceDto>> getAllServices() async {
    return objectBox.serviceBox.getAll();
  }

  @override
  Future<ServiceDto> updateService({
    required int id,
    required int subDateMs,
  }) async {
    final existing = objectBox.serviceBox.get(id);
    if (existing == null) {
      throw StateError('Service with id=$id not found');
    }
    if(existing.subDateMs > DateTime.now().millisecondsSinceEpoch){
      throw StateError('Service with id=$id already has subscribe');
    }

    final updated = existing.copyWith(subDateMs: subDateMs);
    objectBox.serviceBox.put(updated);
    return updated;
  }
}

