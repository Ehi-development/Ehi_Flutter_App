import 'package:shared_preferences/shared_preferences.dart';

const String loggedUsername = 'loggedUsername';
const String loggedPass='loggedPass';

class LoginManager {
  static void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(loggedUsername);
    prefs.remove(loggedPass);
  }

  static void login(username, password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loggedUsername', username);
    prefs.setString('loggedPass', password);
  }

  static Future<Map<String,String>> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedUsername = prefs.getString('loggedUsername') ?? "";
    print(loggedUsername);
    final loggedPass = prefs.getString('loggedPass') ?? "";
    final loggedPhoto = prefs.getString('photo') ?? "";
    if (loggedUsername != "") {
      return {"username": loggedUsername, "password": loggedPass, "photo":loggedPhoto};
    } else {
      return {"username": "", "password": "", "photo":""};
    }
  }
}
