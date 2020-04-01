import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/AppLogoLogin.dart';
import 'package:hey_flutter/UtilityClass/FlushBar.dart';
import 'package:hey_flutter/UtilityClass/ProgressButton.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../UtilityClass/Theme.dart';
import '../UtilityClass/CircularTextBox.dart';
import '../main.dart';
import '../UtilityClass/ContactServerWithAlert.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  RegistrationScreenState createState() => new RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String usernameValue;
  String passwordValue;
  String repeatPasswordValue;

  GlobalKey<ProgressButtonState> registrationProgressButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StatusBarCleaner(
      scaffoldKey: _scaffoldKey,
      gradient: MoobTheme.backgroundGradient,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: MoobTheme.paddingHorizontal*1.5),
            child: Center(
              child: AppLogoLogin()
            ),
          ),
          Expanded(
            child: registrationPage(),
          ),
        ],
      ),
    );
  }

  registrationPage(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            child: Text("Registrazione",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white),),
            padding: EdgeInsets.only(bottom: 16.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*3,vertical: 16.0),
            child: CircularTextBox(
              height: 45,
              color: MoobTheme.mainColor,
              alignRight: true,
              icon: Icons.person,
              elevation: 4,
              onChange: (text){
                usernameValue=text;
              },
              hintText:"Username",
              border: 0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*3,vertical: 16.0),
            child: CircularTextBox(
              height: 45,
              color: MoobTheme.secondaryMainColor,
              alignRight: false,
              icon: Icons.vpn_key,
              elevation: 4,
              onChange: (text){
                passwordValue=text;
              },
              obscureText: true,
              hintText:"Password",
              border: 0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: MoobTheme.paddingHorizontal*3,right: MoobTheme.paddingHorizontal*3,top: 16.0),
            child: CircularTextBox(
              height: 45,
              color: MoobTheme.secondaryMainColor,
              alignRight: false,
              icon: Icons.vpn_key,
              elevation: 4,
              onChange: (text){
                repeatPasswordValue=text;
              },
              obscureText: true,
              hintText:"Ripeti Password",
              border: 0,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: 32.0),
              child: ProgressButton(
                key: registrationProgressButtonKey,
                text: "Registrati",
                textColor: Colors.black,
                onPressed: (){
                  ContactServerWithAlert.checkIfUsernameExist(context: context, username: usernameValue, password: passwordValue, repeatPassword: repeatPasswordValue, ProgressButtonKey: registrationProgressButtonKey);
                },
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*3),
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(child: Text("oppure registrati con",style: TextStyle(color: Colors.white.withOpacity(0.4)),)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*3,vertical: 16),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Center(child: Icon(FontAwesomeIcons.google,color: Color(0xFF4285f4))),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                  ClipOval(
                    child: InkWell(
                      onTap: (){
                        //TODO: Aggiungere "Login con Facebook"
                        //showFlushbar(context:context,title:"TODO",message:"Login con Facebook",icon:Icons.code,color: Colors.green);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Center(child: Icon(FontAwesomeIcons.facebookF,color: Color(0xFF3b5998))),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
