import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/MessagePage.dart';
import 'package:hey_flutter/Pages/NotificationPage.dart';
import 'package:hey_flutter/Pages/FavoritePage.dart';
import 'package:hey_flutter/UtilityClass/BordedButton.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';

import '../Pages/Home.dart';
import 'Theme.dart';

class MoobNavigation extends StatelessWidget
{
  MoobNavigation({Key key, this.position}) : super(key: key);

  final int position;
  final GlobalKey homeButton = GlobalKey();
  final GlobalKey preferenceButton = GlobalKey();
  final GlobalKey notificationButton = GlobalKey();
  final GlobalKey messageButton = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MoobTheme.middleBackgroundColor,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                0.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(18.0),topLeft: Radius.circular(18.0)),
          child: BottomAppBar(
            color: MoobTheme.lightBackgroundColor,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  key:homeButton,
                  icon: Icon(Icons.home, size: 28,
                    color:position==1?Colors.white:Colors.grey[600],
                  ),
                  onPressed: (){Navigator.of(context).push(CircularRevealRoute(widget: Home(),position:getContainerPosition(homeButton)));}
                ),
                IconButton(
                  key:preferenceButton,
                  icon: Icon(Icons.star_border,size: 28,
                    color:position==2?Colors.white:Colors.grey[600],
                  ),
                  onPressed: (){Navigator.of(context).push(CircularRevealRoute(widget: FavoritePage(),position:getContainerPosition(preferenceButton)));}

                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: BordedButton(
                        spacing: 0.0,
                        child: Icon(Icons.add,color: Colors.white,size: 28,),
                        gradient: MoobTheme.primaryGradient,
                        strokeWidth: 2,
                        radius: 24,
                        onPressed: (){},
                      ),
                    )
                ),
                IconButton(
                  key:notificationButton,
                  icon: Icon(Icons.notifications_none,size: 28,
                    color:position==3?Colors.white:Colors.grey[600],
                  ),
                  onPressed: (){Navigator.of(context).push(CircularRevealRoute(widget: NotificationPage(),position:getContainerPosition(notificationButton)));}

                ),
                IconButton(
                  key:messageButton,
                  icon: Icon(Icons.chat_bubble_outline,size: 28,
                    color:position==4?Colors.white:Colors.grey[600],
                  ),
                  onPressed: (){Navigator.of(context).push(CircularRevealRoute(widget: MessagePage(),position:getContainerPosition(messageButton)));}

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}