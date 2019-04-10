import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences 管理类
class PreferenceUtils {
  static PreferenceUtils _instance;

  static PreferenceUtils get instance => PreferenceUtils();

  PreferenceUtils._internal();

  factory PreferenceUtils() {
    if (_instance == null) _instance = PreferenceUtils._internal();
    return _instance;
  }

  saveInteger(String key, int value) => SharedPreferences.getInstance().then((sp) => sp.setInt(key, value));

  saveString(String key, String value) => SharedPreferences.getInstance().then((sp) => sp.setString(key, value));

  saveBool(String key, bool value) => SharedPreferences.getInstance().then((sp) => sp.setBool(key, value));

  saveDouble(String key, double value) => SharedPreferences.getInstance().then((sp) => sp.setDouble(key, value));

  saveStringList(String key, List<String> value) => SharedPreferences.getInstance().then((sp) => sp.setStringList(key, value));

  Future<int> getInteger(String key, [int defaultValue = 0]) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getInt(key);
    return value ?? defaultValue;
  }

  Future<String> getString(String key, [String defaultValue = '']) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getString(key);
    return value ?? defaultValue;
  }

  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getBool(key);
    return value ?? defaultValue;
  }

  Future<double> getDouble(String key, [double defaultValue = 0.0]) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getDouble(key);
    return value ?? defaultValue;
  }

  Future<List<String>> getStringList(String key, [List<String> defaultValue = const <String>[]]) async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getStringList(key);
    return value ?? defaultValue;
  }
}
