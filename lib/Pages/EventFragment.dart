import 'package:flutter/material.dart';

import '../UtilityClass/EventClass.dart';
import '../UtilityClass/EventServer.dart';

class EventFragment extends StatelessWidget{
  final String event_id;

  const EventFragment({Key key,this.event_id,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventClass>(
      future:EventServer.fromServer(event_id),
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            children: ReturnTags(snapshot.data.tags),
          );
        }
        else if (snapshot.hasError) {
          print(snapshot);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(child: Text("Connessione al server interrotta\n Prova più tardi",textAlign: TextAlign.center,)),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(child:Container(child:CircularProgressIndicator(),)),
        );
      }
    );
  }

  ReturnTags(ListOfTags){
    List<Widget> listofWidget = [];
    for (Tag tag in ListOfTags){
      listofWidget.add(Text(tag.tag));
    }
    return listofWidget;
  }

}