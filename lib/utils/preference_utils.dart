import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static void saveInteger(String key, int value) async {
    var share = await SharedPreferences.getInstance();
    await share.setInt(key, value);
  }

  static Future<int> restoreInteger(String key, {int defaultValue = 0}) async {
    var share = await SharedPreferences.getInstance();
    return share.getInt(key) ?? Future.value(defaultValue);
  }

  static void saveBooleans(String key, bool value) async {
    var share = await SharedPreferences.getInstance();
    await share.setBool(key, value);
  }

  static Future<bool> restoreBooleans(String key, {bool defaultValue = false}) async {
    var share = await SharedPreferences.getInstance();
    return share.getBool(key) ?? Future.value(defaultValue);
  }

  static void saveDouble(String key, double value) async {
    var share = await SharedPreferences.getInstance();
    await share.setDouble(key, value);
  }

  static Future<double> restoreDouble(String key, {double defaultValue = 0.0}) async {
    var share = await SharedPreferences.getInstance();
    return share.getDouble(key) ?? Future.value(defaultValue);
  }

  static void saveString(String key, String value) async {
    var share = await SharedPreferences.getInstance();
    await share.setString(key, value);
  }

  static Future<String> restoreString(String key, {String defaultValue = ''}) async {
    var share = await SharedPreferences.getInstance();
    return share.getString(key) ?? Future.value(defaultValue);
  }

  static void saveStringList(String key, List<String> values) async {
    var share = await SharedPreferences.getInstance();
    await share.setStringList(key, values);
  }

  static Future<List<String>> restoreStringList(String key, {List<String> defaultValues}) async {
    var share = await SharedPreferences.getInstance();
    return share.getStringList(key) ?? Future.value(defaultValues);
  }
}
