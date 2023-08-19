import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices {
  static SharedPreferences _prefsInstance;

  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  // get int value
  static int getInt(String key) {
    return _prefsInstance.getInt(key) ?? 0;
  }
  // set int value
  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }


  // get bool value
  static bool getBool(String key) {
    return _prefsInstance.getBool(key) ?? false;
  }
  // set bool value
  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }
}
