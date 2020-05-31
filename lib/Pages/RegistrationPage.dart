import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/LoginPage.dart';
import 'package:hey_flutter/Widget/AppLogoLogin.dart';
import 'package:hey_flutter/Widget/BordedButton.dart';
import 'package:hey_flutter/Widget/MyBehavior.dart';
import 'package:hey_flutter/Widget/ProgressButton.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widget/Theme.dart';
import '../Widget/CircularTextBox.dart';
import '../UtilityClass/ContactServerWithAlert.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  RegistrationPageState createState() => new RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _backToLogin = new GlobalKey<ScaffoldState>();

  String usernameValue;
  String passwordValue;
  String repeatPasswordValue;
  bool passwordHide = true;
  bool repeatPasswordHide = true;

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
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
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
                externalColor: MoobTheme.mainColor,
                alignRight: true,
                icon: Icons.person,
                elevation: 4,
                context: context,
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
                externalColor: MoobTheme.secondaryMainColor,
                alignRight: false,
                icon: Icons.vpn_key,
                elevation: 4,
                context: context,
                onChange: (text){
                  passwordValue=text;
                },
                obscureText: passwordHide,
                hintText:"Password",
                othersideIcon: IconButton(icon: passwordHide ? Icon(Icons.visibility, color: Colors.grey[800]):Icon(Icons.visibility_off, color: Colors.grey[800]),
                 onPressed: (){setState(() {
                  passwordHide=!passwordHide;
                });},),
                border: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: MoobTheme.paddingHorizontal*3,right: MoobTheme.paddingHorizontal*3,top: 16.0),
              child: CircularTextBox(
                height: 45,
                externalColor: MoobTheme.secondaryMainColor,
                alignRight: false,
                icon: Icons.vpn_key,
                elevation: 4,
                context: context,
                onChange: (text){
                  repeatPasswordValue=text;
                },
                obscureText: repeatPasswordHide,
                othersideIcon: IconButton(icon: repeatPasswordHide ? Icon(Icons.visibility, color: Colors.grey[800]):Icon(Icons.visibility_off, color: Colors.grey[800]),
                  onPressed: (){setState(() {
                  repeatPasswordHide=!repeatPasswordHide;
                });},),
                hintText:"Ripeti Password",
                border: 0,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: 32.0),
                child: BordedButton(
                  key: registrationProgressButtonKey,
                  child: Text("Registrati",style: TextStyle(color: Colors.white,fontSize: 14),),
                  gradient: MoobTheme.primaryGradient,
                  strokeWidth: 2,
                  radius: 24,
                  onPressed: (){
                    ContactServerWithAlert.checkIfUsernameExist(
                        context: context,
                        username: usernameValue,
                        password: passwordValue,
                        repeatPassword: repeatPasswordValue,
                        ProgressButtonKey: registrationProgressButtonKey
                    );
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                key: _backToLogin,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Hai già un account?",style: TextStyle(color: Colors.white.withOpacity(0.4)),),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Accedi",style: TextStyle(color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(CircularRevealRoute(widget: LoginPage(),position:getContainerPosition(_backToLogin)));
                },
              ),
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
      ),
    );
  }


}
