import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/Theme.dart';

// ignore: must_be_immutable
class ProgressButton extends StatefulWidget{
  final Function onPressed;
  final String text;
  final Color textColor;

  int state=0;
  GlobalKey _globalKey = new GlobalKey();
  Animation _animation;
  AnimationController _controller;
  double _width = 0;
  double _opacity = 1;

  ProgressButton({Key key,
    this.onPressed,
    @required this.text,
    this.textColor=Colors.black
  }) : super(key: key);


  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: widget._width!=0? widget._width:null,
      child: RaisedButton(
              key: widget._globalKey,
              child: setUpButtonChild(),
              onPressed: (){
                  animateButton();
                  setState(widget.onPressed);
                },
              elevation: 5,
              textColor: Colors.black,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
      )
      );
  }

  Widget setUpButtonChild() {
    if (widget.state == 0) {
      return Opacity(
        opacity: widget._opacity,
        child: new Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16.0,
          ),
          overflow: TextOverflow.fade,
        ),
      );
    } else if (widget.state == 1) {
      return SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(MoobTheme.mainColor),
        ),
      );
    } else if (widget.state == 2) {
      return Center(child:Icon(Icons.check, color: widget.textColor));
    }else if (widget.state == 3) {
      return Center(child:Icon(Icons.error_outline, color: Colors.red));
    }else{
      return Container();
    }
  }

  animateButton(){
    if(widget._width==0) {
      double initialWidth = widget._globalKey.currentContext.size.width;
      widget._controller =
          AnimationController(
              duration: Duration(milliseconds: 300), vsync: this);
      widget._animation =
      Tween(begin: 0.0, end: 1.0).animate(widget._controller)
        ..addListener(() {
          setState(() {
            widget._width = initialWidth -
                ((initialWidth - 56.0) * widget._animation.value);
            if(widget._animation.value>0.25){
              widget._opacity = 0;
            }else{
              widget._opacity = (0.25-widget._animation.value)*4;
            }
          });
        });
    }
  }

  progress(){
    widget._controller.forward();
    setState(() {
      widget.state=1;
    });
  }

  done(){
    setState(() {
      widget.state=2;
    });
  }

  reset(){
    setState(() {
      widget.state=0;
    });
  }

  error(){
    setState(() {
      widget.state=3;
    });
    Timer(Duration(milliseconds: 800),
            () {
          setState(() {
            widget._controller.reverse();
            widget.state = 0;
          });
        });
  }
}