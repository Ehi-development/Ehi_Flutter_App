import 'package:flutter/material.dart';
import 'package:heiserver_connector/Implementation/Event.dart';
import 'package:heiserver_connector/Implementation/User.dart';
import 'package:heiserver_connector/Structure/EventClass.dart';
import 'EventListItem.dart';

class GetListEvent{
  Future<Widget> home() async {
    List<EventClass> listevent = await EventFromServer().home();
    List<Widget> returnedList = [];
    for (EventClass event in listevent) {
      returnedList.add(EventListItem(event:event));
      returnedList.add(Padding(padding: EdgeInsets.all(8.0)));
    }

    return Column(children: returnedList);
  }

  Future<Widget> user(user) async {
    List<EventClass> listevent = await User().getCreatedEvent(user);
    List<Widget> returnedList = [];
    for (EventClass event in listevent) {
      returnedList.add(EventListItem(event:event));
      returnedList.add(Padding(padding: EdgeInsets.all(8.0)));
    }

    return Column(children: returnedList);
  }
}