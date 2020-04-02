import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/getEventFromServer.dart';

import 'EventClass.dart';
import 'EventListItem.dart';

class GetListEvent{
  Widget home() {
    List<EventClass> listevent = getEventFromServer().home();
    List<Widget> returnedList = [];
    for (var event in listevent) {
      returnedList.add(EventListItem(event:event));
      returnedList.add(Padding(padding: EdgeInsets.all(8.0)));
    }

    return Column(children: returnedList);
  }
}