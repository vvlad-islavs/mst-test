import 'package:flutter/foundation.dart';

import 'package:test_task/core/core.dart';

class WelcomeViewModel extends ChangeNotifier {
  WelcomeViewModel({required FirstStartPrefsSource firstStartPrefs}) : _firstStartPrefs = firstStartPrefs;

  final FirstStartPrefsSource _firstStartPrefs;

  // Публичные
  bool get isLoading => _isLoading;

  bool get isFirstStart => _isFirstStart;

  // Приватные
  bool _isLoading = false;
  bool _isFirstStart = true;

  Future<void> load() async {
    try {
      _isFirstStart = await _firstStartPrefs.isFirstStart();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markFirstStartDone() async {
    await _firstStartPrefs.setFirstStartDone();
  }
}
