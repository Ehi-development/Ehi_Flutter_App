import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hey_flutter/UtilityClass/UserClass.dart';
import 'package:hey_flutter/UtilityClass/UserServer.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import 'package:hey_flutter/Widget/AccountImage.dart';
import 'package:hey_flutter/Widget/AppLogoLogin.dart';
import 'package:hey_flutter/Widget/BordedButton.dart';
import 'package:hey_flutter/Widget/DinoAppBar.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/ParallaxContainer.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:hey_flutter/Widget/Theme.dart';

import '../UtilityClass/EventClass.dart';

class EventPage extends StatefulWidget{
  final String event_id;
  final EventClass event;

  const EventPage({Key key, this.event_id, this.event,});

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
    return fakeEvent(widget.event);
  }

  ReturnTags(ListOfTags){
    List<Widget> listofWidget = [];
    for (Tag tag in ListOfTags){
      listofWidget.add(Text(tag.tag));
    }
    return listofWidget;
  }

  Widget fakeEvent(EventClass event){
    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      safeArea: true,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(MoobTheme.radius),
          topRight: const Radius.circular(MoobTheme.radius),
        ),
        child: Stack(
          children: <Widget>[

            ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(
                  controller: _controller,
                  slivers: [
                    /*SliverAppBar(
                        expandedHeight: 250.0,
                        floating: false,
                        pinned: true,
                        centerTitle: true,
                        title: AppLogo(),
                        leading:IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 30,
                          onPressed: () {Navigator.pop(context, false);},
                        ),
                        backgroundColor: MoobTheme.darkBackgroundColor,
                        flexibleSpace: FlexibleSpaceBar(
                          background: CachedNetworkImage(
                            imageUrl: event.photo,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter:
                                    ColorFilter.mode(Colors.black.withOpacity(0.7),
                                        BlendMode.dstATop),
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.red)),
                          ),
                        ),
                    ),*/
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
//                          borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius), topRight: Radius.circular(MoobTheme.radius))
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
                          child: displayAccount(event.followList),
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
                      ]),
                    ),
                    SliverFillRemaining(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                        )
                    ),
                  ]
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: EventNavigation(event),
            ),
          ],
        ),
      ),
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
                  color: Colors.white.withOpacity(0.6))),
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
                      future: UserServer.fromServer(event.creator), // a previously-obtained Future<String> or null
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
        /*GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),*/

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
        /*Padding(
          padding: const EdgeInsets.only(top:MoobTheme.paddingHorizontal),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child:Icon(Icons.star, color: Colors.white, size: 26,),
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
                    Text(tagtoString(event.tags), style: TextStyle(color: Colors.white,fontSize: 16),),
                    Text("Preferenze", style: TextStyle(color: Colors.white,fontSize: 10),),
                  ],
                ),
              )
            ],
          ),
        ),*/
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

  Widget displayAccount(EventFollowList followList){
    return Stack(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left: 51.0),child: SizedBox(height:40,width: 40, child: AccountImage(photo: followList.displaiedAccount[3], format: 64, borderColor: Colors.white,borderWidth: 1))),
        Padding(padding: const EdgeInsets.only(left: 34.0),child: SizedBox(height:40,width: 40, child: AccountImage(photo: followList.displaiedAccount[2], format: 64, borderColor: Colors.white,borderWidth: 1))),
        Padding(padding: const EdgeInsets.only(left: 17.0),child: SizedBox(height:40,width: 40, child: AccountImage(photo: followList.displaiedAccount[1], format: 64, borderColor: Colors.white,borderWidth: 1))),
        Padding(padding: const EdgeInsets.only(left: 0.0),child: SizedBox(height:40,width: 40, child: AccountImage(photo: followList.displaiedAccount[0], format: 64, borderColor: Colors.white,borderWidth: 1))),
        Padding(
          padding: const EdgeInsets.only(left: 70.0, top:12),
          child: Center(child: Text("+${followList.numberofFollow-4} utenti seguono questo evento", style: TextStyle(color: Colors.white),)),
        )
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
              child: SizedBox(
                width: 48,
                height: 48,
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: Colors.grey,
                  child: Icon(
                    Icons.star_border,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  shape: CircleBorder(),
                ),
              )
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
