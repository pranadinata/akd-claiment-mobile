import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUser {
  int value = 0;
  String name = '';
  void savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
  void removePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.commit();
  }
  getUser(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }
}
