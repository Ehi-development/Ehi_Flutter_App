import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heiserver_connector/Implementation/User.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:heiserver_connector/Utility/LocalLoginData.dart';
import 'package:hey_flutter/Pages/LRPage.dart';
import 'package:hey_flutter/Pages/ShowLoggedUserPage.dart';
import 'package:hey_flutter/Widget/AccountImage.dart';
import 'package:hey_flutter/Widget/AppLogoLogin.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import '../UtilityClass/RouteBuilder.dart';
import '../Pages/SearchPage.dart';
import 'Theme.dart';

class SearchAvatar_Appbar extends StatelessWidget{
  final GlobalKey searchButton = GlobalKey();
  final GlobalKey loginPhotoButton = GlobalKey();

  final Color color;
  final Color iconColor;

  SearchAvatar_Appbar({Key key, this.color:MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:color,
          floating: true,
          snap: true,
          leading:IconButton(
            key: searchButton,
            icon: Icon(Icons.search),
            color: iconColor,
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).push(CircularRevealRoute(widget: SearchPage(),position:getContainerPosition(searchButton)));
            },
          ),
          centerTitle: true,
          title: AppLogo(),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            generateUserImageButton()
          ],
      ), padding: EdgeInsets.only(top:0.0),
    );
  }
}

class BackName_Appbar extends StatelessWidget{
  final GlobalKey searchButton = GlobalKey();
  final GlobalKey loginPhotoButton = GlobalKey();

  final Color color;
  final Color iconColor;
  final String name;

  BackName_Appbar({Key key, this.color:MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:color,
        floating: true,
        snap: true,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false,
      ), padding: EdgeInsets.only(top:0.0),
    );
  }
}

class BackLogo_Appbar extends StatelessWidget{
  final Color color;
  final Color iconColor;

  const BackLogo_Appbar({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:color,
        floating: true,
        snap: true,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: AppLogo(),
        automaticallyImplyLeading: false,
      ), padding: EdgeInsets.only(top:0.0),
    );
  }
}

class BackAvatar_Appbar extends StatelessWidget{
  final GlobalKey searchButton = GlobalKey();

  final Color color;
  final Color iconColor;

  BackAvatar_Appbar({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:color,
        floating: true,
        snap: true,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: AppLogo(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          generateUserImageButton(),
        ],
      ), padding: EdgeInsets.only(top:0.0),
    );
  }
}

Widget generateUserImageButton(){
  GlobalKey loginPhotoButton = GlobalKey();

  return FutureBuilder<Map<String,String>>(
      future: LocalLoginData.getLoggedUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData ) {
          return FutureBuilder<UserClass>(
            future: User().fromServer(snapshot.data["username"]),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.result==0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0),
                  child: AspectRatio(
                    child: InkWell(
                      key: loginPhotoButton,
                      onTap: (){
                        Navigator.of(context).push(CircularRevealRoute(widget: ShowLoggedUserPage(),position:getContainerPosition(loginPhotoButton)));
                      },
                      child: AccountImage(photo: snapshot.data.photo, format: 64,)
                    ),
                    aspectRatio: 1/1,
                  ),
                );
              }else{
                return Container();
              }
            }
          );
        }else{
          return AspectRatio(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            aspectRatio: 1/1,
          );
        }
      }
  );
}

class BackSetting_Appbar extends StatelessWidget{
  final Color backgroundColor;
  final Color iconColor;
  final Widget title;

  const BackSetting_Appbar({Key key, this.backgroundColor=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:backgroundColor,
        floating: true,
        snap: true,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: title,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            color: iconColor,
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ), padding: EdgeInsets.only(top:0.0),
    );
    print("");
  }
}

class BackSetting_Collapsing_Appbar extends StatelessWidget{
  final Color color;
  final Color iconColor;
  final Color backgroundColor;
  final String url;
  final double expandedHeight;

  const BackSetting_Collapsing_Appbar({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor, this.url, this.backgroundColor, this.expandedHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        expandedHeight: expandedHeight,
        brightness: Brightness.dark,
        floating: true,
        snap: true,
        pinned: true,
        backgroundColor: backgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      stops: [0, 1],
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent // I don't know what Color this will be, so I can't use this
                      ]
                  )
              ),
            )
        ),
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: AppLogo(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            color: iconColor,
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ), padding: EdgeInsets.only(top:0.0),
    );
  }
}

class Image_Appbar extends StatelessWidget{

  final String imageUrl;

  const Image_Appbar({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw SliverAppBar(
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
          imageUrl: imageUrl,
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
    );
  }

}

class BackSetting_Appbar_LoggedUser extends StatelessWidget{
  final Color color;
  final Color iconColor;

  BackSetting_Appbar_LoggedUser({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);

  final StreamController<bool> _streamController = new StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    _streamController.add(true);

    return SliverPadding(
      sliver: SliverAppBar(
        elevation: 0.0,
        backgroundColor:color,
        floating: true,
        snap: true,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          color: iconColor,
          iconSize: 30,
          onPressed: () {Navigator.pop(context, false);},
        ),
        centerTitle: true,
        title: AppLogo(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert,color: iconColor, size: 30,),
            onPressed: (){
              _settingModalBottomSheet(context);
            },
          ),
        ],
      ), padding: EdgeInsets.only(top:0.0),
    );
  }

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc){
          return Container(
            margin: EdgeInsets.all(MoobTheme.paddingHorizontal),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(MoobTheme.radius)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4, // has the effect of softening the shadow
                  spreadRadius: 2, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    4, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: Icon(Icons.settings,color: MoobTheme.textColor,),
                  title:Text("Impostazioni"),
                  onTap: (){
                    //TODO: inserire Route a Impostazioni
                    //showFlushbar(context:context,title:"TODO",message:"inserire Route a Impostazioni",icon:Icons.code,color: Colors.green);
                  },
                ),
                StreamBuilder<bool>(
                  stream: _streamController.stream.asBroadcastStream(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return new ListTile(
                        leading: Icon(Icons.color_lens,color: MoobTheme.textColor,),
                        title:Text("Impostazioni"),
                        trailing: Checkbox(
                          onChanged: (bool value) {
                            _streamController.add(!snapshot.data);
                          },
                          value: snapshot.data,
                        ),
                        onTap: (){
                          //TODO: inserire Route a Impostazioni
                          //showFlushbar(context:context,title:"TODO",message:"inserire Route a Impostazioni",icon:Icons.code,color: Colors.green);
                        },
                      );
                    }else{
                      return Container();
                    }
                  }
                ),
                new ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red,),
                  title:Text("Logout",style: TextStyle(color: Colors.red)),
                  onTap: (){
                    LocalLoginData.logout();
                    //Navigator.of(context)..pop(true);
                    Navigator.of(context).pushReplacement(CircularRevealRoute(widget: LRPage(),position:Offset(50,50)));
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}
