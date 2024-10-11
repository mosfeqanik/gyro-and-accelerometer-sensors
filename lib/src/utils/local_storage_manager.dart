import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveData(String key, dynamic value) async {
    if (value is int) {
      _prefs?.setInt(key, value);
    } else if (value is String) {
      _prefs?.setString(key, value);
    } else if (value is bool) {
      _prefs?.setBool(key, value);
    } else {
      log("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    dynamic obj = _prefs?.get(key);
    return obj;
  }

  static Future<Future<bool>?> deleteData(String key) async {
    return _prefs?.remove(key);
  }
}