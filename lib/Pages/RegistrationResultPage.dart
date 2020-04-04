import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hey_flutter/Pages/LoginPage.dart';
import 'package:hey_flutter/Widget/BordedButton.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../Widget/DINOAppBar.dart';
import '../Widget/Theme.dart';

class RegistrationResultPage extends StatefulWidget {
  @override
  RegistrationResultPageState createState() => RegistrationResultPageState();
}

class RegistrationResultPageState extends State<RegistrationResultPage> {

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: MoobTheme.middleBackgroundColor,
          body: Center(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(slivers: [
                BackName_Appbar(color: MoobTheme.darkBackgroundColor, name: "Successo",),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal),
                          child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3)),
                              Center(child: Icon(Icons.check_circle_outline,size: 150,color: Colors.white,)),
                              Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3)),
                              Center(child: Text("Registrazione effettuata con successo!",style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)),
                              Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                              Center(child: Text("Ti verrà inviata una mail con il codice di conferma",style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)),
                              Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*2),),
                              Center(
                                child: BordedButton(
                                  key: buttonKey,
                                  strokeWidth: 2,
                                  radius: 24,
                                  child: Text("Torna al Login",style: TextStyle(color: Colors.white)),
                                  gradient: MoobTheme.primaryGradient,
                                  onPressed: (){
                                    Navigator.of(context).pushAndRemoveUntil(CircularRevealRoute(widget: LoginPage(),position:getContainerPosition(buttonKey)),
                                            (Route<dynamic> route) => false);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ]),
                )
              ]),
            ),
          ),
        ),
        //),
      ),
    );
  }
}