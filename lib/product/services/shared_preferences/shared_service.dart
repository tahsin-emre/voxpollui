import 'package:shared_preferences/shared_preferences.dart';

final class SharedService {
  const SharedService._();
  static SharedPreferences? _sharedPreferences;

  static bool get isFirstLogin {
    if (_sharedPreferences == null) {
      throw Exception('SharedService not initialized');
    }
    return _sharedPreferences!.getBool('isFirstLogin') ?? true;
  }

  static Future<void> ensureInitialized() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
