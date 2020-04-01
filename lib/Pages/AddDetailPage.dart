import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/RegistrationResult.dart';
import 'package:hey_flutter/UtilityClass/DINOAppBar.dart';
import 'package:hey_flutter/UtilityClass/ProgressButton.dart';
import 'package:hey_flutter/UtilityClass/UserClass.dart';

import 'package:hey_flutter/UtilityClass/CropImage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import 'package:hey_flutter/UtilityClass/Theme.dart';
import 'package:hey_flutter/UtilityClass/ContactServerWithAlert.dart';

class AddDetailPage extends StatefulWidget {

  String username;
  String password;
  final String image;
  String name;
  String surname;
  String email;
  String bio;
  String birth;
  String place;
  int gender = 1;

  AddDetailPage({Key key, this.username, this.password, this.image}) : super(key: key);

  @override
  AddDetailPageState createState() => AddDetailPageState();
}

class AddDetailPageState extends State<AddDetailPage> {

  GlobalKey circularKey = GlobalKey();
  GlobalKey<ProgressButtonState> progressButtonRegistrationKey = GlobalKey();

  PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      child: CustomScrollView(
          slivers: [
            // Richiamo l'AppBar che presenta un pulsante per tornare indietro e uno per le impostazioni
            BackSetting_Appbar(color:MoobTheme.darkBackgroundColor,),
            SliverList(
                delegate: SliverChildListDelegate(
                    [
                      firstPage(),
                      secondPage(),
                      thirdPage()
                    ]
                )
            ),
          ]
      ),
    );
  }

  Widget firstPage(){
    return Padding(
      padding: const EdgeInsets.all(MoobTheme.paddingHorizontal),
      child: InkWell(
        key: circularKey,
        onTap: (){Navigator.of(context).push(CircularRevealRoute(widget: CropImage(username: widget.username, password: widget.password, position:getContainerPosition(circularKey),),position:getContainerPosition(circularKey)));},
        child: Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white,width: 2),
              image: widget.image==null?
              null
                  :DecorationImage(image: MemoryImage(base64.decode(widget.image)),
                  fit: BoxFit.cover,
              ),
            ),
            child: Center(child: widget.image==null?Icon(Icons.camera_alt,size: 35,color: Colors.white,):null),
          ),
        ),
      ),
    );
  }



  Widget secondPage(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(MoobTheme.radius),topRight: Radius.circular(MoobTheme.radius),),
        border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
        color: MoobTheme.middleBackgroundColor,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: MoobTheme.paddingHorizontal/4),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
              child: TextField(
                enabled: false,
                style: TextStyle(color: Colors.white,),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  labelText: widget.username,
                  suffixIcon: Icon(Icons.person,color: Colors.white,),
                ),
                onChanged: (text){
                  widget.username = text;
                },
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Nome",
                    suffixIcon: Icon(Icons.person,color: Colors.white,),
                  ),
                  onChanged: (text){
                    widget.name = text;
                  },
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Cognome",
                    suffixIcon: Icon(Icons.person,color: Colors.white,),
                  ),
                  onChanged: (text){
                    widget.surname = text;
                  },
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MoobTheme.paddingHorizontal/2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Theme(
              data: ThemeData(
                  unselectedWidgetColor: Colors.grey[600],
                  accentColor: MoobTheme.mainColor
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: widget.gender,
                          onChanged: (value) {
                            setState(() {
                              widget.gender = value;
                            });
                          },
                        ),
                        Text(
                          "Maschio",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 2,
                          groupValue: widget.gender,
                          onChanged: (value) {
                            setState(() {
                              widget.gender = value;
                            });
                          },
                        ),
                        Text(
                          "Femmina",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MoobTheme.paddingHorizontal/2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Email",
                    suffixIcon: Icon(Icons.mail_outline,color: Colors.white,),
                  ),
                  onChanged: (text){
                    widget.email = text;
                  },
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Data di Nascita",
                    suffixIcon: Icon(Icons.calendar_today,color: Colors.white,),
                  ),
                  onChanged: (text){
                    widget.birth = text;
                  },
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Località",
                    suffixIcon: Icon(Icons.place,color: Colors.white,),
                  ),
                  onChanged: (text){
                    widget.place = text;
                  },
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MoobTheme.paddingHorizontal/2),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: null,
                  style: TextStyle(color: Colors.white,),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: Icon(Icons.mode_edit,color: Colors.white, ),
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Biografia",
                  ),
                  onChanged: (text){
                    widget.bio = text;
                  },
                )
            ),
          ),
        ],
      ),
    );
  }


  Widget thirdPage(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal*2),
      decoration: BoxDecoration(
        border: Border.all(color: MoobTheme.middleBackgroundColor,width: 0),
        color: MoobTheme.middleBackgroundColor,
      ),
      child: ProgressButton(
        text: "Fine",
        key: progressButtonRegistrationKey,
        onPressed: (){
          String genderLocale;

          if(widget.gender==1){
            genderLocale="m";
          }else if(widget.gender==2){
            genderLocale="f";
          }else{
            genderLocale="None";
          }

          UserClass user = UserClass(
              username: widget.username,
              password: widget.password,
              surname: widget.surname,
              name: widget.name,
              photo: widget.image,
              email: widget.email,
              bio: widget.bio,
              place: widget.place,
              birth: widget.birth,
              gender: genderLocale,
          );

          ContactServerWithAlert.newUserRegistration(
              context: context,
              ProgressButtonKey: progressButtonRegistrationKey,
              user: user,
          ).then((result){
            if(result==0){
              Navigator.of(context).pushReplacement(CircularRevealRoute(widget: RegistrationResult(),position:getContainerPosition(progressButtonRegistrationKey)));
            }else if(result==1){
              //Navigator.pop(context, false);
            }else if(result==2){
              //Navigator.pop(context, false);
            }else if(result==3){
              //Navigator.pop(context, false);
            }
          });
        },
      ),
    );
  }


}