import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:test_task/core/core.dart';

class PayloadViewModel extends ChangeNotifier {
  PayloadViewModel({required ServicesRepository repository}) : _repository = repository;

  final ServicesRepository _repository;

  // Публичные
  bool get isLoading => _isLoading;

  late Stream<String> errorStream = _errorStreamController.stream;

  String? get lastShownMessage => _lastShownMessage;

  String? get errorMessage => _errorMessage;

  // Приватные
  bool _isLoading = false;
  String? _errorMessage;
  String? _lastShownMessage;

  final StreamController<String> _errorStreamController = StreamController();

  Future<ServiceEntity?> buyService({required int id, required int days}) async {
    _isLoading = true;
    _errorMessage = null;
    _lastShownMessage = null;
    notifyListeners();

    try {
      final updated = await _repository.updateService(id: id, days: days);
      return updated;
    } catch (e) {
      _errorMessage = e.toString();
      log(_errorMessage!, name: '$runtimeType');
      _lastShownMessage = 'Не удалось оформить подписку(';
      _errorStreamController.add(_lastShownMessage ?? '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return null;
  }
}
