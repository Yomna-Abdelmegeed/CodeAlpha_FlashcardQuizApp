import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPrefService._(); // Private constructor to prevent instantiation

  static late SharedPreferences _sharedPreferences;

  //! Here The Initialize of cache (call it in main)
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //! ===============================
  //! General Methods
  //! ===============================

  //* this method to put string data in local database using key
  static Future<bool> setString({
    required String key,
    required String value,
  }) async {
    return await _sharedPreferences.setString(key, value);
  }

  //* this method to get string data from local database using key
  static String? getString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  //* this method to put dynamic data in local database using key
  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    } else {
      throw Exception(
        'Cannot set in shared pref, Unsupported value type: ${value.runtimeType}',
      );
    }
  }

  //* this method to get dynamic data by key already saved in local database
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  //* remove data using specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  //* this method to check if local database contains {key}
  static Future<bool> containsKey({required String key}) async {
    return _sharedPreferences.containsKey(key);
  }

  //* this method to clear local database
  static Future<bool> clearData() async {
    return _sharedPreferences.clear();
  }

  //! ===============================
  //! Helper Methods
  //! ===============================

  // //* this method to save Test model
  // static Future<bool> saveFavorites(List<TestModel> favorites) async {
  //   final encoded = jsonEncode(
  //     favorites.map((Test) => Test.toJson()).toList(),
  //   );

  //   return await setString(key: SharedPrefKeys.favoritesKey, value: encoded);
  // }
}
