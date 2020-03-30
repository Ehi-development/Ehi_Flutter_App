import 'EventClass.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'UtilityTools.dart';

class EventServer{

  static Future<EventClass> fromServer(String id_event) async {
    final response =
    await http.get(UtilityTools.getServerUrl()+'geteventdata/$id_event');
    List<Tag> listofTag = [];

    if (response.statusCode == 200) {
      final digestResponse = json.decode(response.body);
      if(digestResponse['result']==0) {
        for (var tag in digestResponse['event']["tags"]) {
          listofTag.add(Tag(tag:tag["tag"]));
        }
        return EventClass(
          result: digestResponse['result'],
          coordinate: digestResponse['event']["coordinate"],
          creator: digestResponse['event']["creator"],
          desc: digestResponse['event']["desc"],
          id_event: digestResponse['event']["id_event"],
          name: digestResponse['event']["name"],
          place: digestResponse['event']["place"],
          //date: digestResponse['event']["date"],
          photo: digestResponse['event']["photo"],
          tags: listofTag,
        );
      }
      else{
        return EventClass(
            result: digestResponse['result']
        );
      }
    }
  }
}