import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:hey_flutter/Widget/DinoAppBar.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/ProgressButton.dart';

import 'package:hey_flutter/Widget/CropImage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:hey_flutter/Widget/Theme.dart';
import 'package:hey_flutter/UtilityClass/ContactServerWithAlert.dart';

// ignore: must_be_immutable
class AddDetailPage extends StatefulWidget {

  final UserClass user;

  AddDetailPage({Key key, this.user}) : super(key: key);

  @override
  AddDetailPageState createState() => AddDetailPageState();
}

class AddDetailPageState extends State<AddDetailPage> {

  GlobalKey circularKey = GlobalKey();
  GlobalKey<ProgressButtonState> progressButtonRegistrationKey = GlobalKey();

  PageController controller = PageController();

  TextEditingController _usernameController;
  TextEditingController _nameController;
  TextEditingController _surnameController;
  TextEditingController _emailController;
  TextEditingController _placeController;
  TextEditingController _bioController;
  TextEditingController _dateController;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _usernameController = new TextEditingController(text: widget.user.username);

    if (widget.user.birth != null)
      _dateController = new TextEditingController(text: widget.user.birth);

    if (widget.user.name != null)
      print(widget.user.name);
      _nameController = new TextEditingController(text: widget.user.name);
    if (widget.user.surname != null)
    _surnameController = new TextEditingController(text: widget.user.surname);
    if (widget.user.email != null)
    _emailController = new TextEditingController(text: widget.user.email);
    if (widget.user.place != null)
    _placeController = new TextEditingController(text: widget.user.place);
    if (widget.user.bio != null)
    _bioController = new TextEditingController(text: widget.user.bio);
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
              user: widget.user,
              position:getContainerPosition(circularKey),),
            position:getContainerPosition(circularKey)));},
        child: Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white,width: 2),
              image: widget.user.photo==null?
              null
                  :DecorationImage(image: MemoryImage(base64.decode(widget.user.photo)),
                  fit: BoxFit.cover,
              ),
            ),
            child: Center(child: widget.user.photo==null?Icon(Icons.camera_alt,size: 35,color: Colors.white,):null),
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
                  widget.user.username = text;
                },
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  controller: _nameController,
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
                    widget.user.name = text;
                  },
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: MoobTheme.paddingHorizontal/4),
            child: Center(
                child: TextField(
                  controller: _surnameController,
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
                    widget.user.surname = text;
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
                              value: "m",
                              groupValue: widget.user.gender,
                              onChanged: (value) {
                                setState(() {
                                  widget.user.gender = value;
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
                              value: "f",
                              groupValue: widget.user.gender,
                              onChanged: (value) {
                                setState(() {
                                  widget.user.gender = value;
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
                        value: "n",
                        groupValue: widget.user.gender,
                        onChanged: (value) {
                          setState(() {
                            widget.user.gender = value;
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
                  controller: _emailController,
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
                    widget.user.email = text;
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
                  controller: _placeController,
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
                    widget.user.place = text;
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
                  controller: _bioController,
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
                    widget.user.bio = text;
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


          ContactServerWithAlert.newUserRegistration(
              context: context,
              ProgressButtonKey: progressButtonRegistrationKey,
              user: widget.user,
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
          widget.user.birth = "${date.day}/${date.month}/${date.year}";
          setState(() {});
        });
  }
}