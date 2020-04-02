import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Pages/IconPageLoader.dart';
import 'UtilityClass/Theme.dart';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(DINO());
}

// ignore: must_be_immutable
class DINO extends StatelessWidget {
  String title="DINO";

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