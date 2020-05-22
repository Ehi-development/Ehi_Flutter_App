import 'package:dio/dio.dart';
import 'package:hey_flutter/UtilityClass/LoginManager.dart';

import 'UserClass.dart';
import 'UtilityTools.dart';

class FollowUser {
  static Future<int> follow(following) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'following': following,
    });
    var response = await dio.post(
        UtilityTools.getServerUrl() + "follow", data: form);
    if (response.data["result"]==0)
      return 0;
    else
      return 1;
  }

  static Future<int> unfollow(following) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'following': following,
    });
    var response = await dio.post(
        UtilityTools.getServerUrl() + "unfollow", data: form);
    if (response.data["result"]==0)
      return 0;
    else
      return 1;
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
    if(response.data["result"]==0){
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