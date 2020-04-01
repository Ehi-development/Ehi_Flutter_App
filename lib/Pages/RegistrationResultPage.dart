import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/Home.dart';
import 'package:hey_flutter/UtilityClass/BordedButton.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../UtilityClass/DINOAppBar.dart';
import '../UtilityClass/Theme.dart';

class RegistrationResultPage extends StatefulWidget {
  @override
  RegistrationResultPageState createState() => RegistrationResultPageState();
}

class RegistrationResultPageState extends State<RegistrationResultPage> {

  //Data di oggi per il calendario
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    GlobalKey buttonKey = new GlobalKey();

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
                          Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3)),
                          Center(child: Icon(Icons.check_circle_outline,size: 150,color: Colors.white,)),
                          Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3)),
                          Center(child: Text("Registrazione effettuata con successo!",style: TextStyle(color: Colors.white))),
                          Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                          Center(child: Text("Ti verrà inviata una mail con il codice di conferma",style: TextStyle(color: Colors.white),)),
                          Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*2),),
                          Center(
                            child: BordedButton(
                              key: buttonKey,
                              strokeWidth: 2,
                              radius: 24,
                              child: Text("Torna alla Home",style: TextStyle(color: Colors.white)),
                              gradient: MoobTheme.primaryGradient,
                              onPressed: (){
                                Navigator.of(context).pushReplacement(CircularRevealRoute(widget: Home(),position:getContainerPosition(buttonKey)));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ]),
              )
            ]),
          ),
        ),
        //),
      ),
    );
  }
}