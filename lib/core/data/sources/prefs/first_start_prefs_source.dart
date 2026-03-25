import 'package:shared_preferences/shared_preferences.dart';

class FirstStartPrefsSource {
  FirstStartPrefsSource({required SharedPreferences prefs}) : _prefs = prefs;

  static const _key = 'is_first_start';

  final SharedPreferences _prefs;

  Future<bool> isFirstStart() async {
    return _prefs.getBool(_key) ?? true;
  }

  Future<void> setFirstStartDone() async {
    await _prefs.setBool(_key, false);
  }
}

