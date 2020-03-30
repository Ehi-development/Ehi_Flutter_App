import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarCleaner extends StatelessWidget{
  final color;
  final child;
  final gradient;
  final image;

  final GlobalKey<ScaffoldState> scaffoldKey;

  const StatusBarCleaner({Key key, this.color, this.child, this.scaffoldKey, this.gradient, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: gradient==null?color:null,
          gradient:gradient!=null?gradient:null,
          image: image!=null?new DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ):null,
      ),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              child: SafeArea(
                  child: child
              )
          )
      ),
    );
  }
}