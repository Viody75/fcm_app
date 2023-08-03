import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  String user = 'user';

  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(user);
    return token;
  }

  void setUser(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(user, value);
  }
}
