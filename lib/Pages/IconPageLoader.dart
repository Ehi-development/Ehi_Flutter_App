import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/LRPage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import '../UtilityClass/Theme.dart';
import 'Home.dart';

import 'package:after_layout/after_layout.dart';

class IconPageLoader extends StatefulWidget{
  @override
  IconPageLoaderState createState() => IconPageLoaderState();
}

class IconPageLoaderState extends State<IconPageLoader> with AfterLayoutMixin<IconPageLoader> {

  GlobalKey view = GlobalKey();

  @override
  void afterFirstLayout(BuildContext context) {
    UtilityTools.getLoggedUser().then((result){
      if(result[0]==""){
        Navigator.of(context).pushReplacement(CircularRevealRoute(widget: LRPage(),position:getContainerPosition(view)));
      }else{
        Navigator.of(context).pushReplacement(CircularRevealRoute(widget: Home(),position:getContainerPosition(view)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarCleaner(
        key: view,
        gradient: MoobTheme.backgroundGradient,
        child: Center(child: Loading(indicator: BallPulseIndicator(
        ), size: 100.0)),
    );
  }
}