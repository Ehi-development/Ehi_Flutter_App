import 'package:flutter/material.dart';

import 'EventClass.dart';
import 'EventListItem.dart';

EventToColumn(List<EventClass> listevent) {
  List<Widget> returnedList = [];
  for (var event in listevent) {
    returnedList.add(EventListItem(event:event));
    returnedList.add(Padding(padding: EdgeInsets.all(8.0)));
  }

  return Column(children: returnedList);
}