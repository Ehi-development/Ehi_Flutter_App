import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:heiserver_connector/Implementation/FollowUser.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:hey_flutter/Pages/ShowOthersUserPage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/AccountImage.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import '../Widget/MoobNavigation.dart';
import '../Widget/DinoAppBar.dart';
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius),topRight: Radius.circular(MoobTheme.radius),),
                                  border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
                                  color: MoobTheme.lightBackgroundColor,
                                ),
                                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),child: Text("Persone che Segui", style: TextStyle(color: Colors.white),))
                            ),
                            FutureBuilder<List<UserClass>>(
                              future: FollowUser().followingList(),
                              builder: (context, snapshot){
                                if (snapshot.hasData){
                                  List<Widget> list = [];
                                  for (UserClass element in snapshot.data) {
                                    GlobalKey CircleAvatarButton = GlobalKey();
                                    list.add(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(CircularRevealRoute(widget: ShowOthersUserPage(element.username),position:getContainerPosition(CircleAvatarButton)));
                                          },
                                          child: ListTile(
                                            leading: SizedBox(
                                                width: 48,
                                                height: 48,
                                                child: AccountImage(photo: element.photo, format: 64, key: CircleAvatarButton,)
                                            ),
                                            title: Text(StringUtils.capitalize(element.name)+" "+StringUtils.capitalize(element.surname), style: TextStyle(color: Colors.white),),
                                          ),
                                        ),
                                      )
                                    );
                                  }
                                  return Column(children: list);
                                }else{
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        )
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