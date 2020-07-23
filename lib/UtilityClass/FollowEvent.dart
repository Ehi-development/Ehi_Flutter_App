import 'package:dio/dio.dart';
import 'package:hey_flutter/UtilityClass/LoginManager.dart';
import 'package:hey_flutter/Widget/GenerateToast.dart';

import 'UserClass.dart';
import 'UtilityTools.dart';

class FollowEvent {

  static Future<int> follow(event_id) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'event_id': event_id,
    });

    var response = await dio.post(
        UtilityTools.getServerUrl() + "event/follow", data: form);
    if (response.data["result"]==0){
      GenerateToast("Hai iniziato a seguire questo evento");
      return 0;
    }else{
      GenerateToast("Qualcosa è andato storto");
      return 1;
    }
  }


  static Future<int> unfollow(event_id) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var form = FormData.fromMap({
      'follower': follower["username"], 'password': follower["password"], 'event_id': event_id,
    });
    var response = await dio.post(
        UtilityTools.getServerUrl() + "event/unfollow", data: form);
    if (response.data["result"]==0){
      GenerateToast("Hai smesso di seguire questo evento");
      return 0;
    }
    else {
      GenerateToast("Qualcosa è andato storto");
      return 1;
    }
  }

  static Future<bool> isfollower(event_id) async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var response = await dio.get(UtilityTools.getServerUrl() + "event/isfollower/${follower["username"]}/${event_id}");

    return response.data["result"]==0;
  }

  static Future<List<UserClass>> followingList() async {
    var follower = await LoginManager.getLoggedUser();

    var dio = new Dio();
    var response = await dio.get(UtilityTools.getServerUrl() + "user/getlistfollowings/${follower["username"]}");

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