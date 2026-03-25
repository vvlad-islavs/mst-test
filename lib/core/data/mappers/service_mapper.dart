import 'package:test_task/core/domain/entities/entities.dart';
import 'package:test_task/core/data/db/db.dart';

extension ServiceDtoX on ServiceDto {
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      subDateMs: subDateMs,
    );
  }
}

extension ServiceEntityX on ServiceEntity {
  ServiceDto toDto() {
    return ServiceDto(
      id: id,
      title: title,
      subtitle: subtitle,
      subDateMs: subDateMs,
    );
  }
}

