import 'package:flutter/material.dart';

class SlidingMenu extends StatefulWidget {

  final EdgeInsets padding;
  final BuildContext context;
  final double height;
  final double fontSize;
  final String leftText;
  final String rightText;
  final Function onChange;


  const SlidingMenu({Key key, this.padding = const EdgeInsets.all(0), this.context, this.height = 50, this.leftText, this.rightText, this.onChange, this.fontSize=12}) : super(key: key);

  @override
  SlidingMenuState createState() => SlidingMenuState();
}

class SlidingMenuState extends State<SlidingMenu> {

  int selected = 0;

  Color rightColor = Colors.grey[700];
  Color leftColor = Colors.grey[900];

  getSelected(){
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(widget.height/2)),
        ),
        child: CustomPaint(
          painter: TabIndicationPainter(
              context: context,
              padding: widget.padding.left + widget.padding.right,
              radius: widget.height/2,
              dy: widget.height/2,
              selected: selected,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: (){},
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        selected = 0;
                        rightColor = Colors.grey[700];
                        leftColor = Colors.grey[900];
                      });
                    },
                    child: Text(
                      widget.leftText,
                      style: TextStyle(
                          color: leftColor,
                          fontSize: widget.fontSize,
                          fontFamily: "WorkSansSemiBold"),
                    ),
                  )
                ),
              ),
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: (){},
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        selected = 1;
                        leftColor = Colors.grey[700];
                        rightColor = Colors.grey[900];
                      });
                    },
                    child: Text(
                      widget.rightText,
                      style: TextStyle(
                          color: rightColor,
                          fontSize: widget.fontSize,
                          fontFamily: "WorkSansSemiBold"),
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double radius;
  final double dy;
  final double padding;
  final int selected;
  @required final BuildContext context;

  TabIndicationPainter(
      {
        this.selected,
        this.padding,
        this.context,
        this.radius = 25.0,
        this.dy = 25.0,
      }) : super() {
    painter = new Paint()
      ..color = Colors.grey[200]
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {

    double fullExtent = MediaQuery.of(context).size.width;
    double half = (fullExtent-padding)/2-2*radius;

    Offset entry = new Offset(0, dy);
    Offset target = new Offset(half, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * 3.14, 2 * 3.14);
    path.addRect(
        new Rect.fromLTRB(entry.dx, 0, target.dx, 2*radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 0.5 * 3.14, 2 * 3.14);

    if (selected == 0){
      canvas.translate(radius, 0.0);
    }
    else if (selected == 1)
    {
      canvas.translate(half+radius*3, 0.0);
    }
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
