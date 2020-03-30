import 'package:shared_preferences/shared_preferences.dart';

const String loggedUsername = 'loggedUsername';
const String loggedPass='loggedPass';

void Logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(loggedUsername);
  prefs.remove(loggedPass);
}

void Login(username,password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('loggedUsername', username);
  prefs.setString('loggedPass', password);
}
