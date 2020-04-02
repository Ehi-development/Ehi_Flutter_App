import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/AccountImage.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../UtilityClass/DINOAppBar.dart';
import '../UtilityClass/UserClass.dart';
import '../UtilityClass/UserServer.dart';
import '../UtilityClass/Theme.dart';
import 'dart:convert';

class ShowOthersUserPage extends StatefulWidget{
  final String username;

  ShowOthersUserPage(this.username);

  @override
  ShowOthersUserPageState createState() => ShowOthersUserPageState();
}

class ShowOthersUserPageState extends State<ShowOthersUserPage> {

  var buildcontext;

  @override
  Widget build(BuildContext context) {
    buildcontext=context;
    return StatusBarCleaner(
      gradient: MoobTheme.primaryGradient,
      child: CustomScrollView(
          slivers: [
            // Richiamo l'AppBar che presenta un pulsante per tornare indietro e uno per le impostazioni
            BackSetting_Appbar(color:Colors.transparent),
            SliverList(
                delegate: SliverChildListDelegate(
                    [
                      FutureBuilder<UserClass>(
                        future: UserServer.fromServer(widget.username),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //Da qui inizio a riempire il corpo della pagina
                                  getTopUserBar(snapshot.data),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // Di default mostra un CircularProgressIndicator
                          return Padding(
                            padding: const EdgeInsets.only(top:48.0),
                            child: Center(child:Container(child:CircularProgressIndicator(),)),
                          );
                        },
                      ),
                    ])
            ),
          ]
      ),
    );
  }

  getTopUserBar(UserClass user){
    List<Widget> TopUserBar = [];
    TopUserBar.add(Container(
      color: Colors.transparent,
      height:140+2*MoobTheme.paddingHorizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AspectRatio(
              child: AccountImage(photo: user.photo),
              aspectRatio: 1/1,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(flex:1,child: Container(),),
                    AutoSizeText("${user.name} ${user.surname}", style: TextStyle(color: Colors.white), minFontSize: 22, maxFontSize: 24,),
                    Text("@${user.username}", style: TextStyle(fontSize: 16,color: Colors.white),),
                    Flexible(flex:4,child: Container(),),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(Icons.place,size: 14,color: Colors.white,),
                        ),
                        Text("Merine", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    Flexible(flex:1,child: Container(),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
    TopUserBar.add(Container(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Flexible(flex:1,child: Container(),),
            IconButton(icon:Icon(Icons.star,color: Colors.white,),onPressed: (){},),
            Flexible(flex:5,child: Container(),),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.person,color: Colors.white,),
            ),
            Text("210",style: TextStyle(color: Colors.white,fontSize: 18),),
            Flexible(flex:1,child: Container(),),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.favorite,color: Colors.white,),
            ),
            Text("345",style: TextStyle(color: Colors.white,fontSize: 18),),
            Flexible(flex:1,child: Container(),),
          ],
        ),
      ));
    TopUserBar.add(Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:MoobTheme.paddingHorizontal/2),
          child: InkWell(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Dettagli",style: TextStyle(color: Colors.white,fontSize: 16),),
                  Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                ],
              ),
            ),
            onTap: (){},
          ),
        ),
      ));
    
    return Column(children: TopUserBar);
  }
}