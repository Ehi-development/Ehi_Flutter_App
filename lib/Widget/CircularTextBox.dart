import 'package:flutter/material.dart';

class CircularTextBox extends StatefulWidget{
  @override
  CircularTextBoxState createState() => CircularTextBoxState();

  final Color externalColor;
  final Color internalColor;
  final Gradient gradinet;
  final double width;
  final double height;
  final Function onChange;
  final Function onSubmitted;
  final IconData icon;
  final IconButton iconButton;
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
    this.externalColor,
    this.gradinet,
    this.width = double.infinity,
    this.height = 55.0,
    this.onChange,
    this.icon,
    this.iconButton,
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
    this.isEnable=true, this.othersideIcon, this.context, this.internalColor=Colors.white,
  }) : super(key: key);
}

// ignore: must_be_immutable
class CircularTextBoxState extends State<CircularTextBox> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation _animation;

  bool justAnimated = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = IntTween(begin: 100, end: 1).animate(animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if(widget.controller!=null && widget.text != null){
      widget.controller.text = widget.text;
    }else if(widget.controller==null && widget.text != null){
      widget.controller=new TextEditingController(text: widget.text);
    }
    if (widget.alignRight)
      return right();
    else
      return left();
  }

  right() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.isEnable?widget.externalColor:Colors.grey,
          gradient: widget.gradinet,
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: widget.elevation, // has the effect of softening the shadow
              spreadRadius: widget.elevation/2, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                widget.elevation, // vertical, move down 10
              ),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 700,
              child:Padding(
                padding: EdgeInsets.all(widget.border),
                child: Theme(
                  data: Theme.of(widget.context)
                      .copyWith(primaryColor: Colors.grey[900],),
                  child: TextField(
                    style: TextStyle(fontSize: widget.fontSize),
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText,
                    cursorColor: widget.externalColor,
                    controller: widget.controller,
                    enabled: widget.isEnable,
                    decoration: new InputDecoration(
                      prefixIcon: widget.othersideIcon,
                      filled: true,
                      fillColor: widget.internalColor,
                      hintText: widget.hintText,
                      contentPadding: EdgeInsets.symmetric(vertical: (widget.height)/2-8-widget.border,horizontal: 24.0),
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
                    onChanged: widget.onChange,
                    onSubmitted: widget.onSubmitted,
                  ),
                ),
              ),
            ),
            Flexible(
                flex: _animation.value,
                child: Opacity(
                    opacity: _animation.value/100,
                    child: Center(
                        child: widget.icon!=null?Icon(widget.icon,color: Colors.white, size: 20,):widget.iconButton
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  left(){
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.isEnable?widget.externalColor:Colors.grey,
        gradient: widget.gradinet,
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: widget.elevation, // has the effect of softening the shadow
            spreadRadius: widget.elevation/2, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              widget.elevation, // vertical, move down 10
            ),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(flex: 1,child: Center(child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: widget.icon!=null?Icon(widget.icon,color: Colors.white, size: 20,):widget.iconButton,
          ))),
          Flexible(
            flex: 7,
            child:Padding(
              padding: EdgeInsets.all(widget.border),
              child: Theme(
                data: Theme.of(widget.context)
                    .copyWith(primaryColor: Colors.grey[700],),
                child: TextField(
                  cursorColor: widget.externalColor,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  controller: widget.controller,
                  enabled: widget.isEnable,
                  decoration: new InputDecoration(
                    suffixIcon: widget.othersideIcon,
                    filled: true,
                    fillColor: widget.internalColor,
                    hintText: widget.hintText,
                    contentPadding: EdgeInsets.symmetric(vertical: (widget.height)/2-8-widget.border,horizontal: 24.0),
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
                  onChanged: widget.onChange,
                  onSubmitted: widget.onSubmitted,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}