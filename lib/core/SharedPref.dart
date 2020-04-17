import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
    static const String PREFS_KEY = "firebaseKey";

    static Future<void> saveKey(String key) async {
    SharedPreferences.getInstance().then((prefs) {
           prefs.setString(PREFS_KEY, key);
    });
  }

  static Future<String> getFirebaseKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREFS_KEY) ?? "";
  }
}