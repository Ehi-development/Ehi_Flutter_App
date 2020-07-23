import 'package:hey_flutter/UtilityClass/EventFromServer.dart';

import 'UserServer.dart';

class UserClass {
  final int result;
  String username;
  String password;
  String name;
  String surname;
  String email;
  String photo;
  String bio;
  String birth;
  String place;
  String gender;

  UserClass({this.birth, this.place, this.result, this.username, this.password, this.name, this.surname, this.photo,this.bio,this.email,this.gender});

  Future<int> getFollowerNumber() async{
    return await UserServer.getFollowerNumber_FromServer(username);
  }

  Future<int> getFollowingNumber() async {
    return await UserServer.getFollowingNumber_FromServer(username);
  }

  Future<int> getEventCratedNumber() async {
    return await UserServer.getEventNumber_FromServer();
  }

}

