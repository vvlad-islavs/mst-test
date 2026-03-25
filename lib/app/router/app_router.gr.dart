// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [GeneralScreen]
class GeneralRoute extends PageRouteInfo<void> {
  const GeneralRoute({List<PageRouteInfo>? children})
    : super(GeneralRoute.name, initialChildren: children);

  static const String name = 'GeneralRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GeneralScreen();
    },
  );
}

/// generated route for
/// [PayloadScreen]
class PayloadRoute extends PageRouteInfo<PayloadRouteArgs> {
  PayloadRoute({
    Key? key,
    required int serviceId,
    required String title,
    required String subtitle,
    List<PageRouteInfo>? children,
  }) : super(
         PayloadRoute.name,
         args: PayloadRouteArgs(
           key: key,
           serviceId: serviceId,
           title: title,
           subtitle: subtitle,
         ),
         initialChildren: children,
       );

  static const String name = 'PayloadRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayloadRouteArgs>();
      return PayloadScreen(
        key: args.key,
        serviceId: args.serviceId,
        title: args.title,
        subtitle: args.subtitle,
      );
    },
  );
}

class PayloadRouteArgs {
  const PayloadRouteArgs({
    this.key,
    required this.serviceId,
    required this.title,
    required this.subtitle,
  });

  final Key? key;

  final int serviceId;

  final String title;

  final String subtitle;

  @override
  String toString() {
    return 'PayloadRouteArgs{key: $key, serviceId: $serviceId, title: $title, subtitle: $subtitle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PayloadRouteArgs) return false;
    return key == other.key &&
        serviceId == other.serviceId &&
        title == other.title &&
        subtitle == other.subtitle;
  }

  @override
  int get hashCode =>
      key.hashCode ^ serviceId.hashCode ^ title.hashCode ^ subtitle.hashCode;
}

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomeScreen();
    },
  );
}
