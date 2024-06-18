
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref _sharedPref = SharedPref._internal();

  factory SharedPref() {
    return _sharedPref;
  }

  SharedPref._internal();

  static SharedPreferences? _sharedPreferences;
  static const FirstTimeAppOpen = 'FirstTimeAppOpen';

static _initializeSharedPreference() async {
    _sharedPreferences ??= await _getSharedPrefInstance();
  }
  static Future<SharedPreferences> _getSharedPrefInstance() async {
    return await SharedPreferences.getInstance();
  }
  static Future<String> getPreferences(String key) async {
    final _instance = await SharedPreferences.getInstance();
    return _instance.getString(key) ?? "";
  }

  static Future setRestApiData(String key, String data) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(key, data);
  }

  static Future<String?> getRestApiData(String key) async {
    final _instance = await SharedPreferences.getInstance();
    var data = _instance.getString(key);

    if (data != null) {
      return data;
    } else
      return "";
  }

  static Future<Null> setPreferences(String key, String value) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.setString(key, value);
  }

  static Future<bool> getBoolPreferencesWithFallback(
      String key, bool fallback) async {
    final _instance = await SharedPreferences.getInstance();
    return _instance.getBool(key) ?? fallback;
  }

  static Future<bool> getBoolPreferences(String key) async {
    final _instance = await SharedPreferences.getInstance();
    return _instance.getBool(key) ?? false;
  }

  static Future<Null> setBoolPreferences(String key, bool value) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.setBool(key, value);
  }

  static Future<int> getIntPreferences(String key) async {
    final _instance = await SharedPreferences.getInstance();
    return _instance.getInt(key) ?? 0;
  }

  static Future<Null> setIntPreferences(String key, int value) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.setInt(key, value);
  }

  static Future<Null> clearAllPreferences() async {
    final _instance = await SharedPreferences.getInstance();
    _instance.clear();
  }

  static Future setFirstTimeAppOpen(bool status) async {
     await _initializeSharedPreference();
    await _sharedPreferences!.setBool(FirstTimeAppOpen, status);
  }

  static Future<bool> getFirstTimeAppOpen() async {
     await _initializeSharedPreference();
    final res = _sharedPreferences!.getBool(FirstTimeAppOpen);
    if (res == null) return true;
    return res;
  }
  

}
