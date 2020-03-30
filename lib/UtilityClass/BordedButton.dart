import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/Theme.dart';

class BordedButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Color color;
  final Function onPressed;
  final Color internalColor;
  final double height;
  final double width;
  final EdgeInsetsGeometry internalPadding;

  const BordedButton({Key key,
    this.gradient,
    this.color: Colors.blue,
    this.onPressed,
    this.internalColor:Colors.red,
    this.height:null, this.width:null, this.child,
    this.internalPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(300)),
          gradient: gradient,
          color: gradient==null?color:null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(300)),
            color: internalColor
          ),
          child: Padding(
            padding: internalPadding,
            child: child,),
          ),
        ),
      );
  }
}