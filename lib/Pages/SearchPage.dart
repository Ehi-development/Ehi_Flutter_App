import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heiserver_connector/Implementation/Search.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:hey_flutter/Widget/AccountImage.dart';
import 'package:hey_flutter/Widget/DinoAppBar.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/SlidingMenu.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import '../UtilityClass/RouteBuilder.dart';
import '../Widget/Theme.dart';
import 'ShowOthersUserPage.dart';
import '../Widget/CircularTextBox.dart';

class SearchPage extends StatefulWidget{
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  static final GlobalKey <CircularTextBoxState> _formKey = GlobalKey<CircularTextBoxState>();
  var txt = TextEditingController();

  String username;
  static String token = "";

  GlobalKey <SlidingMenuState> sliderKey = GlobalKey<SlidingMenuState>();
  GlobalKey <SearchResultState> searchKey = GlobalKey<SearchResultState>();

  @override
  Widget build(BuildContext context) {
    this.txt.text = token;
    this.txt.selection = TextSelection.fromPosition(TextPosition(offset: txt.text.length));

    return StatusBarCleaner(
        color: MoobTheme.darkBackgroundColor,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
              slivers:[
                BackLogo_Appbar(color:Colors.transparent),
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                        Padding(
                          padding: const EdgeInsets.only(left: MoobTheme.paddingHorizontal,right: MoobTheme.paddingHorizontal, top: MoobTheme.paddingHorizontal/4, bottom: MoobTheme.paddingHorizontal),
                          child: CircularTextBox(
                            key: _formKey,
                            context: context,
                            height: 45,
                            alignRight: true,
                            externalColor: Colors.grey,
                            internalColor: Colors.grey[200],
                            iconButton: IconButton(
                              icon: Icon(Icons.tune, color: Colors.grey[700],),
                               onPressed: () {
                               },
                            ),
                            othersideIcon: Icon(Icons.search),
                            border: 0,
                            hintText: "Cerca tra gli utenti",
                            controller: this.txt,
                            onChange: (text){
                              token=text;
                              searchKey.currentState.setState(() {
                                searchKey.currentState.token=text;
                                searchKey.currentState.searchContext=sliderKey.currentState.selected;
                              });
                            },
                            onSubmitted: (text){
                              token=text;
                              searchKey.currentState.setState(() {
                                searchKey.currentState.token=text;
                                searchKey.currentState.searchContext=sliderKey.currentState.selected;
                              });
                            },
                          ),
                        ),
                        Container(
                          child: SlidingMenu(
                            key: sliderKey,
                            context: context,
                            height: 35,
                            padding: EdgeInsets.only(left: MoobTheme.paddingHorizontal*4, right: MoobTheme.paddingHorizontal*4,  bottom: MoobTheme.paddingHorizontal),
                            leftText: "Eventi",
                            rightText: "Utenti",
                            onRightTap: (){
                              _formKey.currentState.animationController.forward();
                            },
                            onLeftTap: (){
                              _formKey.currentState.animationController.reverse();
                            },
                          ),
                        ),
                        SearchResultWidget(
                          key: searchKey,
                        )
                      ])
              ),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    color: MoobTheme.middleBackgroundColor,
                  ),
                ),
              ]),
        )
    );
  }

  imageLoader(photo){
    if(photo==""){
      NetworkImage("https://www.virtualdj.com/images/v9/menu/menu-login.png");
    }
    else{
      MemoryImage(base64.decode(photo));
    }
  }

}

class SearchResultWidget extends StatefulWidget{

  const SearchResultWidget({Key key}) : super(key: key);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResultWidget>{

  String token;
  int searchContext;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius),topRight: Radius.circular(MoobTheme.radius),),
          border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
          color: MoobTheme.middleBackgroundColor,
        ),
        child: Center(
          child:token!=""?FutureBuilder<List<UserClass>>(
            future: search(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
              {
                if (snapshot.data.length==0){
                  if (searchContext == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(child: Text(
                        "Nessun utente trovato",
                        textAlign: TextAlign.center,)),
                    );
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(child: Text(
                        "Non si possono ancora cercare eventi",
                        textAlign: TextAlign.center,)),
                    );
                  }
                }
                else
                  return searchUserToList(snapshot.data);
              }else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(child: Text("Connessione al server interrotta\n Prova più tardi",textAlign: TextAlign.center,)),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(48.0),
                child: Center(child:Container(child:CircularProgressIndicator(),)),
              );
            },
          ):
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(child: Text("Tocca la casella di ricerca\n per iniziare una nuova ricerca",textAlign: TextAlign.center,)),
          ),

        )
    );
  }

  Future<List<UserClass>> search() async{
    if (searchContext == 0){
      return await Search().searchUser(token);
    } else {
      return [];
    }
  }

  searchUserToList(List<UserClass> listOfUsers){
    List<Widget> returnedList = [];
    for (UserClass user in listOfUsers)
    {
      GlobalKey CircleAvatarButton = GlobalKey();
      returnedList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            Navigator.of(context).push(CircularRevealRoute(widget: ShowOthersUserPage(user.username),position:getContainerPosition(CircleAvatarButton)));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Text(user.name+" "+user.surname, style: TextStyle(color: Colors.white),),
              leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: AccountImage(key: CircleAvatarButton,photo: user.photo)
              ),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
          ),
        ),
      ),
      );
    }

    return Column(children: returnedList);
  }
}