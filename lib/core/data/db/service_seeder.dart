import 'dtos/service_dto.dart';
import 'objectbox_store.dart';


/// Временный сервися для мок данных сервисов
class ServiceSeeder {
  ServiceSeeder();

  static final _services = <ServiceDto>[
    ServiceDto(
      id: 1,
      title: 'YouTube',
      subtitle: 'Смотрите без рекламы и с офлайн-воспроизведением.',
      subDateMs: 0,
    ),
    ServiceDto(
      id: 2,
      title: 'Spotify',
      subtitle: 'Музыка и подкасты с качеством и офлайн-режимом.',
      subDateMs: 0,
    ),
    ServiceDto(
      id: 3,
      title: 'Apple Music',
      subtitle: 'Персональные рекомендации и любимые плейлисты.',
      subDateMs: 0,
    ),
    ServiceDto(
      id: 4,
      title: 'Я.Музыка',
      subtitle: 'Слушайте музыку и подкасты без ограничений.',
      subDateMs: 0,
    ),
  ];

  /// Заполняет Бд, если данных еще нет
  Future<void> seedIfEmpty(ObjectBoxStore objectBox) async {
    final current = objectBox.serviceBox.getAll();
    if (current.isNotEmpty) return;

    objectBox.serviceBox.putMany(_services);
  }
}

