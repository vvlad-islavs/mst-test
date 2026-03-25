import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_task/core/data/db/objectbox_store.dart';
import 'package:test_task/core/data/repositories/services_repository_impl.dart';
import 'package:test_task/core/data/sources/prefs/first_start_prefs_source.dart';
import 'package:test_task/core/data/sources/services/service_box_source.dart';
import 'package:test_task/core/data/sources/services/service_source.dart';
import 'package:test_task/core/domain/repositories/services_repository.dart';
import 'package:test_task/features/general/presentation/view_models/view_models.dart';
import 'package:test_task/features/payload/presentation/view_models/view_models.dart';
import 'package:test_task/features/welcome/presentation/view_models/view_models.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({
  required SharedPreferences prefs,
  required ObjectBoxStore objectBoxStore,
}) async {
  // In dev mode `main()` may run multiple times; avoid duplicate registrations.
  if (getIt.isRegistered<FirstStartPrefsSource>()) {
    getIt.reset();
  }

  // Data sources.
  getIt.registerSingleton<FirstStartPrefsSource>(
    FirstStartPrefsSource(prefs: prefs),
  );

  getIt.registerSingleton<ServiceSource>(
    ServiceBoxSource(objectBox: objectBoxStore),
  );

  // Repositories.
  getIt.registerSingleton<ServicesRepository>(
    ServicesRepositoryImpl(
      serviceSource: getIt<ServiceSource>(),
    ),
  );

  // ViewModels.
  getIt.registerLazySingleton<WelcomeViewModel>(
    () => WelcomeViewModel(firstStartPrefs: getIt<FirstStartPrefsSource>()),
  );
  getIt.registerLazySingleton<GeneralViewModel>(
    () => GeneralViewModel(repository: getIt<ServicesRepository>()),
  );
}

