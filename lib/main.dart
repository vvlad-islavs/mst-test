import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_task/app/router/router.dart';
import 'package:test_task/core/data/db/objectbox_store.dart';
import 'package:test_task/core/data/db/service_seeder.dart';
import 'package:test_task/core/di/service_locator.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final sharedPrefs = await SharedPreferences.getInstance();
      final objectBoxStore = await initObjectBoxStore();

      await ServiceSeeder().seedIfEmpty(objectBoxStore);
      await configureDependencies(prefs: sharedPrefs, objectBoxStore: objectBoxStore);

      runApp(MyApp(appRouter: AppRouter()));
    },
    (error, stack) {
      log('Ошибка на уровне приложения: $error. Stack: $stack');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
    );
  }
}
