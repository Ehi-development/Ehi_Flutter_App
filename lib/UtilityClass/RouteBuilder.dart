import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class CircularRevealRoute extends PageRouteBuilder {
  final Widget widget;
  final Offset position;
  static var curve = Curves.easeIn;
  static var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
  CircularRevealRoute({this.widget,this.position})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return CircularRevealAnimation(
          child: child,
          animation: animation.drive(tween),
          center: position,
        );
      }
  );
}

getContainerPosition(GlobalKey _containerKey) {
  final RenderBox containerRenderBox =
  _containerKey.currentContext.findRenderObject();

  final containerPosition = containerRenderBox.localToGlobal(Offset.zero)+Offset(containerRenderBox.size.width/2,containerRenderBox.size.height/2);;

  return containerPosition;
}