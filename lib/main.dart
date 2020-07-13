import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'Pages/IconPageLoader.dart';
import 'Widget/Theme.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: MoobTheme.lightBackgroundColor,
  ));

  runApp(DINO());
}

// ignore: must_be_immutable
class DINO extends StatelessWidget {
  String title="Ehi";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          fontFamily: 'LouisGeorgeCafe',
          primaryColor: Colors.white,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,color: MoobTheme.textColor),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,color: MoobTheme.textColor),
            body1: TextStyle(color: MoobTheme.textColor),
          ),
          accentColor: Colors.transparent,
        ),
        home: IconPageLoader(),
        debugShowCheckedModeBanner:false,
    );
  }
}