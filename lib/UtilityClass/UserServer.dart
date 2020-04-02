import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserClass.dart';
import 'UtilityTools.dart';

class UserServer {
  static Future<int> loginUser(username,password) async {
    var dio = new Dio();
    var response = await dio.post(UtilityTools.getServerUrl()+"login",data: {'username':username,'password':password});
    return response.data["result"];
  }

  static Future<int> registerUser ({
    UserClass user,
  }) async {
    var dio = new Dio();

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

    var response = await dio.post(UtilityTools.getServerUrl()+"signin",data: {
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
    return response.data["result"];
  }

  static Future<UserClass> fromServer(String username) async {
    var dio = new Dio();
    final response =
    await dio.get(UtilityTools.getServerUrl()+'getuserdata/$username');

    if (response.statusCode == 200) {
      if(response.data['result']==0) {
        final prefs = await SharedPreferences.getInstance();
        if(username==prefs.getString("username")??""){
          prefs.setString('photo', response.data["user"]['photo']);
        }

        return UserClass(
          result: response.data['result'],
          username: response.data["user"]['username'],
          name: response.data["user"]['name'],
          surname: response.data["user"]['surname'],
          bio: response.data["user"]['bio'],
          photo: response.data["user"]['photo'],
          email: response.data["user"]['email'],
          birth: response.data["user"]['birth'],
          place: response.data["user"]['place'],
        );
      }
      else{
        return UserClass(
            result: response.data['result']
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