import 'package:flutter/material.dart';
import 'package:heiserver_connector/Implementation/Event.dart';
import 'package:heiserver_connector/Implementation/User.dart';
import 'package:heiserver_connector/Structure/EventClass.dart';
import 'EventListItem.dart';
import 'Theme.dart';

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
    if (listevent.length != 0) {
      returnedList.add(Container(child: Text("Eventi Creati", style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))),);
      returnedList.add(Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal),),);
      for (EventClass event in listevent) {
        returnedList.add(EventListItem(event: event));
        returnedList.add(Padding(padding: EdgeInsets.all(8.0)));
      }
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: returnedList
    );
  }
}