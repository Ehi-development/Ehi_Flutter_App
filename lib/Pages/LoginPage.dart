import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/IconPageLoader.dart';
import 'package:hey_flutter/Pages/RegistrationPage.dart';
import 'package:hey_flutter/UtilityClass/AppLogoLogin.dart';
import 'package:hey_flutter/UtilityClass/BordedButton.dart';
import 'package:hey_flutter/UtilityClass/MyBehavior.dart';
import 'package:hey_flutter/UtilityClass/ProgressButton.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/UtilityClass/StatusBarCleaner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../UtilityClass/Theme.dart';
import '../UtilityClass/CircularTextBox.dart';
import '../UtilityClass/ContactServerWithAlert.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> _backToRegistration = new GlobalKey<ScaffoldState>();
  bool _passwordHide = true;

  String usernameValue;
  String passwordValue;

  GlobalKey<ProgressButtonState> loginProgressButtonKey = GlobalKey();

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
              child: AppLogoLogin(),
            ),
          ),
          Expanded(
            child: loginPage(),
          ),
        ],
      ),
    );
  }

  loginPage(){
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              child: Text("Login",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white),),
              padding: EdgeInsets.only(bottom: 16.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*3,vertical: 16.0),
              child: CircularTextBox(
                height: 45,
                color: MoobTheme.mainColor,
                alignRight: true,
                icon: Icons.person,
                context: context,
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
                context: context,
                othersideIcon: IconButton(icon: _passwordHide ? Icon(Icons.visibility):Icon(Icons.visibility_off),
                 onPressed: (){setState(() {
                  _passwordHide=!_passwordHide;
                });},),
                onChange: (text){
                  passwordValue=text;
                },
                obscureText: _passwordHide,

                hintText:"Password",
                border: 0,
              ),
            ),
            InkWell(
              child: Center(child: Text("Hai dimenticato la tua password?",style: TextStyle(color: Colors.white.withOpacity(0.4)),)),
              onTap: (){
                //TODO: Aggiungere "hai dimenticato la password?"
                //showFlushbar(context:context,title:"",message:"hai dimenticato la tua password?",icon:Icons.code,color: Colors.green);
              },
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal,vertical: 32.0),
                child: Center(
                    child: BordedButton(
                      key: loginProgressButtonKey,
                      child: Text("Accedi",style: TextStyle(color: Colors.white,fontSize: 14),),
                      gradient: MoobTheme.primaryGradient,
                      strokeWidth: 2,
                      radius: 24,
                      onPressed: (){ContactServerWithAlert.checkLogin(
                          context:context,
                          username:usernameValue.toLowerCase(),
                          password: passwordValue).then((result){
                        if(result==0){
                          Navigator.of(context).pushReplacement(CircularRevealRoute(widget: IconPageLoader(),position:getContainerPosition(loginProgressButtonKey)));
                        }
                      });
                      },
                    )
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                key: _backToRegistration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Non hai un account?",style: TextStyle(color: Colors.white.withOpacity(0.4)),),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Registrati",style: TextStyle(color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushReplacement(CircularRevealRoute(widget: RegistrationPage(),position:getContainerPosition(_backToRegistration)));
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
              child: Center(child: Text("oppure accedi con",style: TextStyle(color: Colors.white.withOpacity(0.4)),)),
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
      ),
    );
  }
}
