class ServiceEntity {
  final int id;
  final String title;
  final String subtitle;
  final int subDateMs;

  const ServiceEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.subDateMs,
  });

  ServiceEntity copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? subDateMs,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      subDateMs: subDateMs ?? this.subDateMs,
    );
  }

  bool get hasSubscribe =>
      subDateMs > DateTime
          .now()
          .millisecondsSinceEpoch;

  int get subscribeDays => _getSubscribeDays();

  int _getSubscribeDays() {
    const msPerDay = 24 * 60 * 60 * 1000;
    final msDays = subDateMs - DateTime.now().millisecondsSinceEpoch;
    return(msDays/msPerDay).round();
  }
}

