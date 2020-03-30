import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/LorRScreen.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import '../UtilityClass/Theme.dart';
import 'Home.dart';

class IconPageLoader extends StatefulWidget{
  @override
  IconPageLoaderState createState() => IconPageLoaderState();
}

class IconPageLoaderState extends State<IconPageLoader> {

  GlobalKey view = GlobalKey();

  @override
  Widget build(BuildContext context) {

    LoadContent(context,view);

    return StatusBarCleaner(
        key: view,
        gradient: MoobTheme.backgroundGradient,
        child: Center(child: Loading(indicator: BallPulseIndicator(), size: 100.0)),
    );
  }
}

void LoadContent(context, view) async {
  UtilityTools.getLoggedUser().then((result){
    if(result[0]==""){
      Navigator.of(context).pushReplacement(CircularRevealRoute(widget: LorRScreen(),position:getContainerPosition(view)));
    }else{
      Navigator.of(context).pushReplacement(CircularRevealRoute(widget: Home(),position:getContainerPosition(view)));
    }
  });
}