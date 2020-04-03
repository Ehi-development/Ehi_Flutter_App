import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularTextBox extends StatelessWidget{
  final Color color;
  final Gradient gradinet;
  final double width;
  final double height;
  final Function onChange;
  final Function onSubmitted;
  final IconData icon;
  final String hintText;
  final bool alignRight;
  final bool obscureText;
  final double border;
  final double fontSize;
  final TextInputType keyboardType;
  TextEditingController controller;
  final double elevation;
  final String text;
  final bool isEnable;
  final Widget othersideIcon; 

  @required final context;

   CircularTextBox({
    Key key,
    this.color,
    this.gradinet,
    this.width = double.infinity,
    this.height = 55.0,
    this.onChange,
    this.icon,
    this.hintText,
    this.alignRight=false,
    this.border=0.0,
    this.fontSize = 16,
    this.obscureText = false,
    this.onSubmitted,
    this.keyboardType=TextInputType.text,
    this.controller,
    this.elevation=0,
    this.text,
    this.isEnable=true, this.othersideIcon, this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller!=null && text != null){
      controller.text = text;
    }else if(controller==null && text != null){
      controller=new TextEditingController(text: text);
    }
    if (this.alignRight)
      return right();
    else
      return left();
  }

  right() {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color: this.isEnable?this.color:Colors.grey,
        gradient: this.gradinet,
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: this.elevation, // has the effect of softening the shadow
            spreadRadius: this.elevation/2, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              this.elevation, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 7,
            child:Padding(
              padding: EdgeInsets.all(this.border),
              child: Theme(
                data: Theme.of(this.context)
                    .copyWith(primaryColor: Colors.redAccent,),
                child: TextField(
                  style: TextStyle(fontSize: this.fontSize),
                  keyboardType: this.keyboardType,
                  obscureText: this.obscureText,
                  cursorColor: this.color,
                  controller: this.controller,
                  enabled: this.isEnable,
                  decoration: new InputDecoration(
                    prefixIcon: this.othersideIcon,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: this.hintText,
                    contentPadding: EdgeInsets.symmetric(vertical: (this.height)/2-8-this.border,horizontal: 24.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0),),
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(32.0),),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onChanged: this.onChange,
                  onSubmitted: this.onSubmitted,
                ),
              ),
            ),
          ),
          Flexible(flex: 1,child: Center(child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(this.icon,color: Colors.white, size: 20,),
          ))),
        ],
      ),
    );
  }

  left(){
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color: this.isEnable?this.color:Colors.grey,
        gradient: this.gradinet,
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: this.elevation, // has the effect of softening the shadow
            spreadRadius: this.elevation/2, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              this.elevation, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(flex: 1,child: Center(child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(this.icon,color: Colors.white, size: 20,),
          ))),
          Flexible(
            flex: 7,
            child:Padding(
              padding: EdgeInsets.all(this.border),
              child: Theme(
                data: Theme.of(this.context)
                    .copyWith(primaryColor: Colors.grey[900],),
                child: TextField(
                  cursorColor: this.color,
                  keyboardType: this.keyboardType,
                  obscureText: this.obscureText,
                  controller: this.controller,
                  enabled: this.isEnable,
                  decoration: new InputDecoration(
                    suffixIcon: this.othersideIcon,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: this.hintText,
                    contentPadding: EdgeInsets.symmetric(vertical: (this.height)/2-8-this.border,horizontal: 24.0),
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0),),
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                    ),
                    border: new OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(32.0),),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onChanged: this.onChange,
                  onSubmitted: this.onSubmitted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}