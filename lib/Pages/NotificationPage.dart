import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/MyBehavior.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../UtilityClass/MoobNavigation.dart';
import '../UtilityClass/DINOAppBar.dart';
import '../UtilityClass/Theme.dart';

class NotificationPage extends StatefulWidget {

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {

  //Data di oggi per il calendario
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(MoobTheme.radius),
          topRight: const Radius.circular(MoobTheme.radius),
        ),
        child: Scaffold(
          primary: false,
          key: _scaffoldKey,
          backgroundColor: MoobTheme.middleBackgroundColor,
          body: Center(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(slivers: [
                SearchAvatar_Appbar(color: MoobTheme.darkBackgroundColor,),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: MoobTheme.darkBackgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius),topRight: Radius.circular(MoobTheme.radius),),
                          border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
                          color: MoobTheme.middleBackgroundColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                            Center(child: Icon(Icons.notifications_none,size: 150,color: Colors.white,)),
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                            Center(child: Text("Non hai nessuna notifica",style: TextStyle(color: Colors.white),)),
                          ],
                        ),
                      ),
                    ),

                  ]),
                )
              ]),
            ),
          ),
          bottomNavigationBar: MoobNavigation(position: 3),
        ),
        //),
      ),
    );
  }
}