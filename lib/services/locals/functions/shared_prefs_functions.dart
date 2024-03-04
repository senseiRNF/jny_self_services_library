import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsFunctions {
  static Future<SharedPreferences> _init() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();

    return sPrefs;
  }

  static Future<bool> writeData(String key, String data) async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.setString(key, data).then((_) {
        result = true;
      });
    });

    return result;
  }

  static Future<String?> readData(String key) async {
    String? result;

    await _init().then((sPrefs) {
      result = sPrefs.getString(key);
    });

    return result;
  }

  static Future<bool> removeData(String key) async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.remove(key).then((_) {
        result = true;
      });
    });

    return result;
  }

  static Future<bool> removeAllData() async {
    bool result = false;

    await _init().then((sPrefs) async {
      await sPrefs.clear().then((_) {
        result = true;
      });
    });

    return result;
  }
}