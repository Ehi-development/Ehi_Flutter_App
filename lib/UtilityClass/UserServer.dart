import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserClass.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'UtilityTools.dart';

class UserServer {
  static Future<int> loginUser(username,password) async {
    var response = await http.post(UtilityTools.getServerUrl()+"login",body: {'username':username,'password':password});
    final digestResponse = json.decode(response.body);
    return digestResponse["result"];
  }

  static Future<int> registerUser ({
    UserClass user,
  }) async {
    if(user.username==null){user.username="NONE";}
    if(user.password==null){user.password="NONE";}
    if(user.email==null){user.email="NONE";}
    if(user.name==null){user.name="NONE";}
    if(user.surname==null){user.surname="NONE";}
    if(user.photo==null){user.photo="NONE";}
    if(user.bio==null){user.bio="NONE";}
    if(user.place==null){user.place="NONE";}
    if(user.birth==null){user.birth="NONE";}
    if(user.gender==null){user.gender="NONE";}

    var response = await http.post(UtilityTools.getServerUrl()+"signin",body: {
      'username':user.username,
      'password':user.password,
      'name':user.name,
      'surname':user.surname,
      'photo':user.photo,
      'email':user.email,
      'bio': user.bio,
      'place': user.place,
      'birth': user.birth,
      'gender': user.gender,
    });
    print(response.body);
    final digestResponse = json.decode(response.body);
    return digestResponse["result"];
  }

  static Future<UserClass> fromServer(String username) async {
    final response =
    await http.get(UtilityTools.getServerUrl()+'getuserdata/$username');

    if (response.statusCode == 200) {
      final digestResponse = json.decode(response.body);
      if(digestResponse['result']==0) {
        final prefs = await SharedPreferences.getInstance();
        if(username==prefs.getString("username")??""){
          prefs.setString('photo', digestResponse["user"]['photo']);
        }

        return UserClass(
          result: digestResponse['result'],
          username: digestResponse["user"]['username'],
          name: digestResponse["user"]['name'],
          surname: digestResponse["user"]['surname'],
          bio: digestResponse["user"]['bio'],
          photo: digestResponse["user"]['photo'],
          email: digestResponse["user"]['email'],
          birth: digestResponse["user"]['birth'],
          place: digestResponse["user"]['place'],
        );
      }
      else{
        return UserClass(
            result: digestResponse['result']
        );
      }
    }else{
      return UserClass(
          result: 1
      );
    }
  }

  static Future<int> getFollowerNumber_FromServer(username) async {
    var dio = new Dio();
    var result = await dio.get("${UtilityTools.getServerUrl()}getnumberfollowers/${username}");
    return result.data["n_followers"];
  }

  static Future<int> getFollowingNumber_FromServer(username) async{
    var dio = new Dio();
    var result = await dio.get("${UtilityTools.getServerUrl()}getnumberfollowings/${username}");
    return result.data["n_followings"];
  }

  static Future<int> getEventNumber_FromServer() async {
    return await getZero();
  }
}

Future<int> getZero() async {
  return 0;
}