import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/EventClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginManager.dart';
import 'UserClass.dart';
import 'UserServer.dart';

class UtilityTools{
  //static String serverUrl="http://moob.bluedev.tech:5005/";
  //static String serverUrl="http://192.168.1.89:5005/";
  static String serverUrl="http://2.226.154.164:5005/";

  static String getServerUrl(){
    return serverUrl;
  }

  static logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedUsername');
    prefs.remove('loggedPass');
    prefs.remove('photo');
  }

  static Future<UserClass> getLoggedUserFromServer() async{
    var loggedUser = await LoginManager.getLoggedUser();
    return UserServer.fromServer(loggedUser["username"]);
  }

  static String DayNumberToShortString(int i){
    List<String> giorno = ["Lun","Mar","Mer","Gio","Ven","Sab","Dom"];

    return giorno[i-1];
  }

  static String MonthNumberToLongString(int i){
    List<String> mese = ["Gennaio","Febraio","Marzo","Aprile","Maggio","Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre"];

    return mese[i-1];
  }

  static TagToIcons(Tag tag){
    switch (tag.tag){
      case "Musica":
        return Icons.music_note;
      case "Cibo":
        return Icons.fastfood;
      case "Sport":
        return Icons.directions_run;
    }
  }
}