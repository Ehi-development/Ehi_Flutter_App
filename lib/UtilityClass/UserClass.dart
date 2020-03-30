import 'package:shared_preferences/shared_preferences.dart';
import '../FragmentManager.dart';

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

}