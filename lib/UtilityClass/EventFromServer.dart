import 'package:dio/dio.dart';

import 'EventClass.dart';
import 'LoginManager.dart';
import 'UtilityTools.dart';

class EventFromServer {
  Future<List<EventClass>> home() async {
    List<EventClass> returnedList = [];
    var dio = new Dio();
    var loggedUser = await LoginManager.getLoggedUser();

    if (loggedUser["username"] != "" && loggedUser["password"] != "") {
      var form = FormData.fromMap({
        'username': loggedUser["username"], 'password': loggedUser["password"],
      });
      var response = await dio.post(
          UtilityTools.getServerUrl() + "getevent/home", data: form);

      if (response.data["result"] == 0) {
        for (var event in response.data["event"]) {
          returnedList.add(
              EventClass(
                  id_event: event["event_id"],
                  name: event["name"],
                  photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR5ftq77i_uaywvUW_XbtUzZgX6RZenuGZ_Nw&usqp=CAU",
                  place: event["place"],
                  startDate: DateTime.parse(event["begin"]),
                  endDate: DateTime.parse(event["end"]),
                  tags: parseTags(event["tags"])
              )
          );
        }
      }
    }
    return returnedList;
  }

  Future<EventClass> event(event_id) async {
    var dio = new Dio();
    var response = await dio.get(
        UtilityTools.getServerUrl() + "getevent/event/$event_id");

    if (response.data["result"] == 0) {
      return EventClass(
          id_event: response.data["event"]["event_id"],
          name: response.data["event"]["name"],
          photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR5ftq77i_uaywvUW_XbtUzZgX6RZenuGZ_Nw&usqp=CAU",
          place: response.data["event"]["place"],
          startDate: DateTime.parse(response.data["event"]["begin"]),
          endDate: DateTime.parse(response.data["event"]["end"]),
          tags: parseTags(response.data["event"]["tags"]),
          desc: response.data["event"]["description"],
          link: response.data["event"]["link"],
          price: response.data["event"]["price"],
          trusted: response.data["event"]["trusted"]=="True",
          coordinate: response.data["event"]["coordinate"],
          creator: response.data["event"]["creator"],
          address: Address(address: "Via di qui ora",number: "4"),
          followList: EventFollowList(["Tadsdcz50_18229499","guilliman_13072020185607067645","yotobi_6439802423424297","ragnar_196843219456487451"],200)
      );
    }
  }

  Future<List<EventClass>> user(user) async {
    List<EventClass> returnedList = [];
    var dio = new Dio();
    var loggedUser = await LoginManager.getLoggedUser();

    if (loggedUser["username"] != "" && loggedUser["password"] != "") {
      var form = FormData.fromMap({
        'username': loggedUser["username"], 'password': loggedUser["password"],
      });
      var response = await dio.post(
          UtilityTools.getServerUrl() + "getevent/user/$user", data: form);

      if (response.data["result"] == 0) {
        for (var event in response.data["event"]) {
          returnedList.add(
              EventClass(
                  id_event: event["event_id"],
                  name: event["name"],
                  photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR5ftq77i_uaywvUW_XbtUzZgX6RZenuGZ_Nw&usqp=CAU",
                  place: event["place"],
                  startDate: DateTime.parse(event["begin"]),
                  endDate: DateTime.parse(event["end"]),
                  tags: parseTags(event["tags"])
              )
          );
        }
      }
    }
    return returnedList;
  }
}

List<Tag> parseTags(tags) {
  List<Tag> listofTag = [];
  if (tags != "None"){
    for (var tag in tags){
      listofTag.add(Tag(
          tag: tag["tag"]
      ));
    }
  }
  return listofTag;
}