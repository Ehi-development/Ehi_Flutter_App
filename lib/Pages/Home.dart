import 'package:flutter/material.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';

import '../Widget/GetListEvent.dart';
import '../Widget/MoobNavigation.dart';
import '../Widget/DINOAppBar.dart';
import '../Widget/Theme.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

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
                backgroundColor: MoobTheme.darkBackgroundColor,
                body: Center(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: CustomScrollView(
                      slivers: [
                        SearchAvatar_Appbar(color:MoobTheme.darkBackgroundColor,),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            getHeader(),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(MoobTheme.radius),
                                topRight: const Radius.circular(MoobTheme.radius),
                              ),
                              child: Container(
                                color: MoobTheme.middleBackgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical:MoobTheme.paddingHorizontal,horizontal: MoobTheme.paddingHorizontal),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left:MoobTheme.paddingHorizontal,bottom:MoobTheme.paddingHorizontal),
                                          child: Text("Tutti gli Eventi",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                                        ),
                                        GetListEvent().home()
                                      ],
                                  )
                                ),
                              ),
                            ),
                          ]),
                        )
                    ]),
                  ),

                ),
                bottomNavigationBar: MoobNavigation(position: 1),
              ),
              //),
            ),
    );
  }

  getHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:MoobTheme.paddingHorizontal,vertical:MoobTheme.paddingHorizontal/2),
      child: Row(
        children: <Widget>[
          Icon(Icons.place,color: Colors.white,size: 18,),
          Text("  Lecce",style: TextStyle(color: Colors.white),),
          Spacer(
            flex: 2,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: MoobTheme.lightBackgroundColor),
              borderRadius: BorderRadius.all(
                Radius.circular(MoobTheme.radius/2),)
            ),
            height: 40,
            width: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${UtilityTools.DayNumberToShortString(today.weekday)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: MoobTheme.mainColor
                  ),
                ),
                Text(
                  "${today.day}",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}


