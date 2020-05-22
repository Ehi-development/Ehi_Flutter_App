import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hey_flutter/Widget/DINOAppBar.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/ProgressButton.dart';
import 'package:hey_flutter/UtilityClass/UserClass.dart';

import 'package:hey_flutter/Widget/CropImage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:hey_flutter/Widget/Theme.dart';
import 'package:hey_flutter/UtilityClass/ContactServerWithAlert.dart';

// ignore: must_be_immutable
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

  TextEditingController _usernameController;
  TextEditingController _dateController;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _usernameController = new TextEditingController(text: widget.username);
    _dateController = new TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {

    return StatusBarCleaner(
      color: MoobTheme.darkBackgroundColor,
      child: ScrollConfiguration(
          behavior: MyBehavior(),
        child: CustomScrollView(
            slivers: [
              // Richiamo l'AppBar che presenta un pulsante per tornare indietro e uno per le impostazioni
              BackName_Appbar(color:MoobTheme.darkBackgroundColor, name: "Crea profilo"),
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
      ),
    );
  }

  Widget firstPage(){
    return Padding(
      padding: const EdgeInsets.all(MoobTheme.paddingHorizontal),
      child: InkWell(
        key: circularKey,
        onTap: (){Navigator.of(context).push(CircularRevealRoute(
            widget: CropImage(
              username: widget.username,
              password: widget.password,
              position:getContainerPosition(circularKey),),
            position:getContainerPosition(circularKey)));},
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
                controller: _usernameController,
                readOnly: true,
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
                  labelText: "Username",
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
              child: Column(
                children: <Widget>[
                  Row(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Radio(
                        value: 3,
                        groupValue: widget.gender,
                        onChanged: (value) {
                          setState(() {
                            widget.gender = value;
                          });
                        },
                      ),
                      Text(
                        "Preferisco non specificarlo",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
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
                  controller: _dateController,
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
                  readOnly: true,

                  onTap: () => _selectDate(context),
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
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(MoobTheme.radius),
                      ),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(MoobTheme.radius),
                      ),
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
            genderLocale="n";
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
          );
        },
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1900, 1, 1),
        maxTime: DateTime.now(),
        theme: DatePickerTheme(
            headerColor: Colors.grey[300],
            backgroundColor: Colors.grey[100],
            itemStyle: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
                fontSize: 18),
            doneStyle:
            TextStyle(color: Colors.grey[900], fontSize: 16)),
        onConfirm: (date) {
          _dateController = new TextEditingController(text: "${date.day}/${date.month}/${date.year}");
          widget.birth = "${date.day}/${date.month}/${date.year}";
          setState(() {});
        });
  }
}