import 'package:dio/dio.dart';
import 'package:hey_flutter/UtilityClass/LoginManager.dart';
import 'package:hey_flutter/Widget/GenerateToast.dart';

import 'UserClass.dart';
import 'UtilityTools.dart';

class FollowUser {
  static Future<int> follow(following) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'following': following,
    });
    if (follower["username"].toLowerCase() != following.toLowerCase()) {
      var response = await dio.post(
          UtilityTools.getServerUrl() + "follow", data: form);
      if (response.data["result"]==0){
        GenerateToast("Hai iniziato a seguire \n ${following}");
        return 0;
      }else{
        GenerateToast("Qualcosa è andato storto");
        return 1;
      }
    }else{
      GenerateToast("Non puoi seguire te stesso. \n Ti becchi una denuncia.");
      return 1;
    }
  }

  static Future<int> unfollow(following) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'following': following,
    });
    var response = await dio.post(
        UtilityTools.getServerUrl() + "unfollow", data: form);
    if (response.data["result"]==0){
      GenerateToast("Hai smesso di seguire \n ${following}");
      return 0;
    }
    else {
      GenerateToast("Qualcosa è andato storto");
      return 1;
    }
  }

  static Future<int> isfollower(following) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var response = await dio.get(UtilityTools.getServerUrl() + "isfollower/${follower["username"]}/${following}");

    return response.data["result"];
  }

  static Future<List<UserClass>> followingList() async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var response = await dio.get(UtilityTools.getServerUrl() + "getlistfollowings/${follower["username"]}");

    List<UserClass> usersList= [];
    if(response.data["result"]==0 ){
      for (var user in response.data["list_user"]){
        usersList.add(UserClass(
          username: user["username"],
          name: user["name"],
          surname: user["surname"],
          photo: user["photo"],
          bio: user["bio"],
        ));
      }
    }

    return usersList;
  }
}