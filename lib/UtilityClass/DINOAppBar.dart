import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/LRPage.dart';
import 'package:hey_flutter/Pages/ShowLoggedUserPage.dart';
import 'package:hey_flutter/UtilityClass/AccountImage.dart';
import 'package:hey_flutter/UtilityClass/AppLogoLogin.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import '../Pages/LoginPage.dart';
import 'RouteBuilder.dart';
import '../Pages/SearchPage.dart';
import 'UserClass.dart';
import 'UserServer.dart';
import '../main.dart';
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


class BackAvatar_Appbar extends StatelessWidget{
  final GlobalKey searchButton = GlobalKey();

  final Color color;
  final Color iconColor;

  BackAvatar_Appbar({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
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

  return FutureBuilder<List<String>>(
      future: UtilityTools.getLoggedUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData && (DINO.isFistAccess || snapshot.data[1]=="")) {
          DINO.isFistAccess = false;
          return FutureBuilder<UserClass>(
              future: UserServer.fromServer(snapshot.data[0]),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.result==0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(MoobTheme.radius*4)),
                          border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          key: loginPhotoButton,
                          child: Icon(Icons.account_circle,size: 34,color: MoobTheme.darkBackgroundColor,),
                          onTap: (){Navigator.of(context).push(CircularRevealRoute(widget: LoginPage(),position:getContainerPosition(loginPhotoButton)));},
                        ),
                      ),
                      aspectRatio: 1/1,
                    ),
                  );

                }});
        }else if(snapshot.hasData && !DINO.isFistAccess ){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              child: InkWell(
                key: loginPhotoButton,
                onTap: (){
                  Navigator.of(context).push(CircularRevealRoute(widget: ShowLoggedUserPage(),position:getContainerPosition(loginPhotoButton)));
                },
                child: AccountImage(photo: snapshot.data[1], format: 64,)
              ),
              aspectRatio: 1/1,
            ),
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
  final Color color;
  final Color iconColor;

  const BackSetting_Appbar({Key key, this.color=MoobTheme.mainColor, this.iconColor:MoobTheme.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverAppBar(
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
                    UtilityTools.logoutUser();
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
