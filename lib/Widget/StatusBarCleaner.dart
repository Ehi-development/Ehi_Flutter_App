import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hey_flutter/Widget/Theme.dart';

class StatusBarCleaner extends StatefulWidget{
  final color;
  final child;
  final gradient;
  final image;

  final GlobalKey<ScaffoldState> scaffoldKey;

  const StatusBarCleaner({Key key, this.color, this.child, this.scaffoldKey, this.gradient, this.image}) : super(key: key);

  @override
  StatusBarCleanerState createState() => StatusBarCleanerState();
}

class StatusBarCleanerState extends State<StatusBarCleaner>{


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.gradient==null?widget.color:null,
          gradient:widget.gradient!=null?widget.gradient:null,
          image: widget.image!=null?new DecorationImage(
            image: widget.image,
            fit: BoxFit.cover,
          ):null,
      ),
      child: Scaffold(
          key: widget.scaffoldKey,
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                systemNavigationBarColor: MoobTheme.lightBackgroundColor,
                statusBarColor: Colors.transparent,
              ),
              child: SafeArea(
                  child: widget.child
              )
          )
      ),
    );
  }
}