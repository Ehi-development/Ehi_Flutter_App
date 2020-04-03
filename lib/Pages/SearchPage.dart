import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hey_flutter/UtilityClass/AccountImage.dart';
import 'package:hey_flutter/UtilityClass/DINOAppBar.dart';
import 'package:hey_flutter/UtilityClass/MyBehavior.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import '../UtilityClass/RouteBuilder.dart';
import '../UtilityClass/Theme.dart';
import '../UtilityClass/UserClass.dart';
import 'package:http/http.dart' as http;
import '../UtilityClass/UtilityTools.dart';
import 'ShowOthersUserPage.dart';
import '../UtilityClass/CircularTextBox.dart';

class SearchPage extends StatefulWidget{
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  static final _formKey = GlobalKey<FormState>();
  var txt = TextEditingController();

  String username;
  static String token = "";

  @override
  Widget build(BuildContext context) {
    txt.text = token;

    return StatusBarCleaner(
        gradient: MoobTheme.primaryGradient,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(
              slivers:[
                        BackSetting_Appbar(color:Colors.transparent),
                SliverList(
                    delegate: SliverChildListDelegate(
                        [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: 16.0),
                          child: CircularTextBox(
                            key: _formKey,
                            height: 45,
                            color: MoobTheme.secondaryMainColor,
                            icon: Icons.search,
                            border: 0,
                            hintText: "Cerca tra gli utenti",
                            controller: this.txt,
                            onChange: (text){token=text;},
                            onSubmitted: (text){
                              setState(() {
                                token=text;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: 8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(MoobTheme.radius),
                              ),
                              child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child:token!=""?FutureBuilder<List<UserClass>>(
                                      future: searchQuery(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData)
                                        {
                                          if (snapshot.data.length==0)
                                            return Padding(
                                              padding: const EdgeInsets.all(24.0),
                                              child: Center(child: Text("Nessun utente trovato",textAlign: TextAlign.center,)),
                                            );
                                          else
                                            return searchQueryToList(snapshot.data);
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
                              )
                          ),
                        )
                      ])
              )
              ]),
        )
    );
  }

  Future<List<UserClass>> searchQuery() async{
    List<UserClass> usersList= [];
    var response = await http.get(UtilityTools.getServerUrl()+'searchusername/$token');
    final digestResponse = json.decode(response.body);
    if(digestResponse["result"]==0){
      for (var user in digestResponse["list_user"]){
        usersList.add(UserClass(
            username: user["username"],
            name: user["name"],
            surname: user["surname"],
            photo: user["photo"],
            bio: user["bio"],
        ));
      }
      return usersList;
    }
    else{
      return [];
    }
  }

  searchQueryToList(List<UserClass> listOfUsers){
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
                title: Text(user.name+" "+user.surname),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: AccountImage(key: CircleAvatarButton,photo: user.photo)
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
        ),
      );
    }

    return Column(children: returnedList);
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