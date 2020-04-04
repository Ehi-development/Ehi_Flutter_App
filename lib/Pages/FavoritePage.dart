import 'package:flutter/material.dart';
import 'package:hey_flutter/Widget/BordedButton.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../Widget/MoobNavigation.dart';
import '../Widget/DINOAppBar.dart';
import '../Widget/Theme.dart';

class FavoritePage extends StatefulWidget {

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {

  //Data di oggi per il calendario
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(MoobTheme.radius),
          topRight: const Radius.circular(MoobTheme.radius),
        ),
        child: Scaffold(
          primary: false,
          key: _scaffoldKey,
          backgroundColor: MoobTheme.middleBackgroundColor,
          body: Center(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: CustomScrollView(slivers: [
                SearchAvatar_Appbar(color: MoobTheme.darkBackgroundColor,),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: MoobTheme.darkBackgroundColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius),topRight: Radius.circular(MoobTheme.radius),),
                          border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
                          color: MoobTheme.middleBackgroundColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                            Center(child: Icon(Icons.star_border,size: 150,color: Colors.white,)),
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*3),),
                            Center(child: Text("Nessun contenuto presente nella lista preferiti",style: TextStyle(color: Colors.white),)),
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal),),
                            Center(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal),
                              child: Text("Clicca la stella su un evento o su un utente per aggiungerlo alla tua lista dei preferiti",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                            )),
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal*2),),
                            Center(
                              child: BordedButton(
                                strokeWidth: 2,
                                radius: 24,
                                child: Text("Torna alla Home",style: TextStyle(color: Colors.white),),
                                gradient: MoobTheme.primaryGradient,
                                onPressed: (){},
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: MoobTheme.paddingHorizontal),),
                            Center(
                              child: BordedButton(
                                strokeWidth: 2,
                                radius: 24,
                                child: Text("Trova amici",style: TextStyle(color: Colors.white),),
                                gradient: MoobTheme.primaryGradient,
                                onPressed: (){},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ]),
                )
              ]),
            ),
          ),
          bottomNavigationBar: MoobNavigation(position: 2),
        ),
        //),
      ),
    );
  }
}