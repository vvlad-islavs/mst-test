import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import 'package:test_task/features/general/presentation/screens/screens.dart';
import 'package:test_task/features/payload/presentation/screens/screens.dart';
import 'package:test_task/features/welcome/presentation/screens/screens.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  final routes = [
    AutoRoute(
      page: WelcomeRoute.page,
      initial: true,
    ),
    AutoRoute(page: GeneralRoute.page),
    AutoRoute(page: PayloadRoute.page),
  ];
}

