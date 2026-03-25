import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceDto {
  @Id(assignable: true)
  int id;

  String title;
  String subtitle;
  int subDateMs;

  ServiceDto({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.subDateMs,
  });

  ServiceDto copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? subDateMs,
  }) {
    return ServiceDto(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      subDateMs: subDateMs ?? this.subDateMs,
    );
  }
}

