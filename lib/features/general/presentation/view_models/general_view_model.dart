import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:test_task/core/core.dart';

class GeneralViewModel extends ChangeNotifier {
  GeneralViewModel({required ServicesRepository repository}) : _repository = repository;

  final ServicesRepository _repository;

  // публичные
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  String? get lastShownMessage => _lastShownMessage;

  late Stream<String> errorStream = _errorStreamController.stream;

  List<ServiceEntity> get services => List.unmodifiable(_services);

  // Приватные
  bool _isLoading = false;
  String? _errorMessage;
  String? _lastShownMessage;
  List<ServiceEntity> _services = const [];

  final StreamController<String> _errorStreamController = StreamController();

  Future<void> getAllServices() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    _lastShownMessage = null;
    notifyListeners();

    try {
      _services = await _repository.getAllServices();
    } catch (e) {
      _errorMessage = e.toString();
      log(_errorMessage!, name: '$runtimeType');
      _lastShownMessage = 'Не удалось получить список сервисов(';
      _errorStreamController.add(_lastShownMessage ?? '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void upsertService(ServiceEntity updated) {
    final index = _services.indexWhere((s) => s.id == updated.id);
    if (index == -1) {
      _services = [updated, ..._services];
    } else {
      final next = [..._services];
      next[index] = updated;
      _services = next;
    }
    notifyListeners();
  }
}
