import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceHelper {
  void setSharedPrefString({key, value}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(key, value);
  }

  Future<String?> getSharedPrefString({key}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(key);
  }

  void clearAllThePrefData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }
}
