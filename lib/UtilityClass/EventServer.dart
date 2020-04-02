import 'package:dio/dio.dart';

import 'EventClass.dart';
import 'UtilityTools.dart';

class EventServer{

  static Future<EventClass> fromServer(String id_event) async {
    var dio = new Dio();
    final response = await dio.get(UtilityTools.getServerUrl()+'geteventdata/$id_event');
    List<Tag> listofTag = [];

    if (response.statusCode == 200) {
      if(response.data['result']==0) {
        for (var tag in response.data['event']["tags"]) {
          listofTag.add(Tag(tag:tag["tag"]));
        }
        return EventClass(
          result: response.data['result'],
          coordinate: response.data['event']["coordinate"],
          creator: response.data['event']["creator"],
          desc: response.data['event']["desc"],
          id_event: response.data['event']["id_event"],
          name: response.data['event']["name"],
          place: response.data['event']["place"],
          //date: digestResponse['event']["date"],
          photo: response.data['event']["photo"],
          tags: listofTag,
        );
      }
      else{
        return EventClass(
            result: response.data['result']
        );
      }
    }else{
      return EventClass(
          result: 1
      );
    }
  }
}