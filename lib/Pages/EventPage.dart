import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heiserver_connector/Implementation/Event.dart';
import 'package:heiserver_connector/Implementation/FollowEvent.dart';
import 'package:heiserver_connector/Implementation/User.dart';
import 'package:heiserver_connector/Structure/AddressClass.dart';
import 'package:heiserver_connector/Structure/EventClass.dart';
import 'package:heiserver_connector/Structure/TagClass.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import 'package:hey_flutter/Widget/AccountImage.dart';
import 'package:hey_flutter/Widget/AppLogoLogin.dart';
import 'package:hey_flutter/Widget/BordedButton.dart';
import 'package:hey_flutter/Widget/DinoAppBar.dart';
import 'package:hey_flutter/Widget/FollowButton.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/ParallaxContainer.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:hey_flutter/Widget/Theme.dart';

class EventPage extends StatefulWidget{
  final int event_id;

  const EventPage({Key key, this.event_id,});

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> with SingleTickerProviderStateMixin{
  var top = 0.0;
  var parallaxHeight = 200.0;

  GlobalKey <ParallaxContainerState> parallaxKey = GlobalKey<ParallaxContainerState>();
  final _controller = ScrollController();

  void _scrollListener(){
    double scroll = (parallaxHeight-_controller.position.pixels)/4;
    if(scroll>0){
      parallaxKey.currentState.scroll.jumpTo(scroll);
    }
  }

  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      safeArea: true,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(MoobTheme.radius),
            topRight: const Radius.circular(MoobTheme.radius),
          ),
          child: getFutureEvent(widget.event_id)
      ),
    );
  }

  Widget getFutureEvent(int event_id){
    return FutureBuilder<EventClass>(
      future: EventFromServer().event(event_id),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return getEventPage(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getEventPage(EventClass event){
    return Stack(
      children: <Widget>[
        ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
              controller: _controller,
              slivers: [
                BackSetting_Appbar(
                  title: AppLogo(),
                  backgroundColor: MoobTheme.darkBackgroundColor,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ParallaxContainer(
                      key: parallaxKey,
                      imageUrl: event.photo,
                      height: this.parallaxHeight,
                      controller: _controller,
                    ),
                    Container(
//                      transform: Matrix4.translationValues(0.0, -MoobTheme.radius, 0.0),
                      padding: EdgeInsets.only(top: MoobTheme.paddingHorizontal, left: MoobTheme.paddingHorizontal, right: MoobTheme.paddingHorizontal),
                      child: Text(event.name, style: TextStyle(color: Colors.white, fontSize: 28),),
                      decoration: BoxDecoration(
                        color: MoobTheme.middleBackgroundColor,
//                        borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius), topRight: Radius.circular(MoobTheme.radius))
                      ),
                    ),
                    Container(
//                        transform: Matrix4.translationValues(0.0, -MoobTheme.radius, 0.0),
                        padding: EdgeInsets.all(MoobTheme.paddingHorizontal),
                        color: MoobTheme.middleBackgroundColor,
                        child: getDetail(event)
                    ),
                    /*Transform.scale(
                          scale:MoobTheme.radius*2+1,
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: MoobTheme.middleBackgroundColor,
                            ),
                          ),
                        ),*/
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal, vertical: 8.0),
                      color: MoobTheme.middleBackgroundColor,
                      child: displayAccount(event.id_event),
                    ),
                    Container(
                        color: MoobTheme.middleBackgroundColor,
                        child: getDescription(event)
                    ),
                    Container(
//                        transform: Matrix4.translationValues(0.0, -MoobTheme.radius, 0.0),
                        padding: EdgeInsets.all(MoobTheme.paddingHorizontal),
                        color: MoobTheme.middleBackgroundColor,
                        child: getOtherDetail(event)
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),
                      color: MoobTheme.middleBackgroundColor,
                    )
                  ]),
                ),
              ]
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: EventNavigation(event),
        ),
      ],
    );
  }

  Widget getDescription(EventClass event){
    if (event.desc != null) {
      return Padding(
        padding: const EdgeInsets.only(top: MoobTheme.paddingHorizontal, right: MoobTheme.paddingHorizontal, left: MoobTheme.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Descrizione", style: TextStyle(fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(event.desc,
                  style: TextStyle(
                  color: Colors.white.withOpacity(0.6)),
                  textAlign: TextAlign.justify),
            )
          ],
        ),
      );
    }else{
      return Container(height: MoobTheme.paddingHorizontal,);
    }
  }

  Widget getOtherDetail(EventClass event){

    Completer<GoogleMapController> _controller = Completer();

    const LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        event.link!=null?Padding(
          padding: const EdgeInsets.only(bottom: MoobTheme.paddingHorizontal),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.link, color: Colors.white, size: 26,),
              Container(
                width: MoobTheme.paddingHorizontal,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("${event.link}", overflow: TextOverflow.fade, maxLines: 1, softWrap: false, style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text("link", style: TextStyle(color: Colors.white,fontSize: 10),),
                ],
              ),
            ],
          ),
        ):Container(),
         Row(
           mainAxisSize: MainAxisSize.max,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Icon(Icons.attach_money, color: Colors.white, size: 26,),
             Container(
               width: MoobTheme.paddingHorizontal,
             ),
             Column(
               mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 event.price!=null?Text("${event.price}", style: TextStyle(color: Colors.white,fontSize: 16)):Text("Gratis", style: TextStyle(color: Colors.white,fontSize: 16)),
                 Text("prezzo", style: TextStyle(color: Colors.white,fontSize: 10),),
               ],
             ),
           ],
         ),
        Padding(
          padding: const EdgeInsets.only(top:MoobTheme.paddingHorizontal),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child:Icon(Icons.account_circle, color: Colors.white, size: 26,),
              ),
              Container(
                width: MoobTheme.paddingHorizontal,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FutureBuilder<UserClass>(
                      future: User().fromServer(event.creator), // a previously-obtained Future<String> or null
                      builder: (BuildContext context, AsyncSnapshot<UserClass> snapshot) {
                        if (snapshot.hasData) {
                          return Text("${snapshot.data.name} ${snapshot.data.surname}", style: TextStyle(color: Colors.white,fontSize: 16),);
                        }
                        else{
                          return CircularProgressIndicator();
                        }
                      }
                    ),
                    Text("Creatore", style: TextStyle(color: Colors.white,fontSize: 10),),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }



  Widget getDetail(EventClass event){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.calendar_today, color: Colors.white, size: 26,),
            Container(
              width: MoobTheme.paddingHorizontal,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("${event.startDate.day} ${UtilityTools.MonthNumberToLongString(event.startDate.month)} ${event.startDate.year}", style: TextStyle(color: Colors.white,fontSize: 16)),
                Text("dalle ${event.startDate.hour}:${event.startDate.minute} alle ${event.endDate.hour}:${event.endDate.minute}", style: TextStyle(color: Colors.white,fontSize: 11))
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:MoobTheme.paddingHorizontal),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.place, color: Colors.white, size: 26,),
              Container(
                width: MoobTheme.paddingHorizontal,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("${event.place}", style: TextStyle(color: Colors.white,fontSize: 16),),
                  Text(addresstoString(event.address), style: TextStyle(color: Colors.white,fontSize: 10),),
                ],
              ),
            ],
          ),
        ),
        getTagCips(event.tags)
      ],
    );
  }

  Widget getTagCips(List<Tag> tags){
    List<Widget> tagcips = [];
    for (Tag elmnt in tags){
      tagcips.add(
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(MoobTheme.radius))
              ),
              child: Text(elmnt.tag, style: TextStyle(fontWeight: FontWeight.bold, color: MoobTheme.middleBackgroundColor),),
            ),
          )
      );

    }
      return Padding(
        padding: const EdgeInsets.only(top: MoobTheme.paddingHorizontal),
        child: Row(children: tagcips),
      );
  }

  String tagtoString(List<Tag> tagList){
    String tags = "";
    for (Tag tag in tagList){
      if (tag == tagList.last)
        tags += "${tag.tag}";
      else
        tags += "${tag.tag}, ";
    }
    return tags;
  }

  String addresstoString(Address address){
    return "${address.address}, ${address.number}";
  }

  Widget displayAccount(int event_id){
    double leftSpacing = 0.0;
    return Stack(
      children: <Widget>[
        FutureBuilder<List<String>>(
          future: FollowEvent().getPhotoOFFolloweroFrinds(event_id),
          builder: (context, snapshot){
            if (snapshot.hasData){
              List<Widget> photoList = [];
              leftSpacing = 0.0;
              for (String photo in snapshot.data){
                photoList.add(
                  Padding(padding: EdgeInsets.only(left: leftSpacing),child: SizedBox(height:40,width: 40, child: AccountImage(photo: photo, format: 64, borderColor: Colors.white,borderWidth: 1)))
                );
                leftSpacing += 17.0;
              }
              return Stack(
                children: photoList,
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        FutureBuilder<int>(
          future: FollowEvent().getnumberfollowers(event_id),
          builder: (context, snapshot){
            if (snapshot.hasData){
              return Padding(
                padding: EdgeInsets.only(left: 100, top:12),
                child: Text("${snapshot.data} utenti seguono questo evento", style: TextStyle(color: Colors.white)),
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

      ],
    );
  }

  EventNavigation(EventClass event) {
    return Padding(
      padding: const EdgeInsets.all(MoobTheme.paddingHorizontal/2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: MoobTheme.paddingHorizontal/4, right: MoobTheme.paddingHorizontal/4),
              child: FollowButton(event_id: event.id_event,)
          ),
          Padding(
            padding: const EdgeInsets.only(left: MoobTheme.paddingHorizontal/4, right: MoobTheme.paddingHorizontal/4),
            child: SizedBox(
              width: 48,
              height: 48,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Colors.grey,
                child: Icon(
                  Icons.share,
                  size: 24.0,
                  color: Colors.white,
                ),
                shape: CircleBorder(),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: MoobTheme.paddingHorizontal/2),
            child: BordedButton(
              radius: 24,
              gradient: MoobTheme.primaryGradient,
              onPressed: () {  },
              strokeWidth: 24,
              child: Text("Chat", style: TextStyle(color: Colors.white, fontSize: 14),),
            ),
          ),
        ],
      ),
    );
  }
}

