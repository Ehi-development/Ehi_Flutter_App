import 'package:flutter/material.dart';
import 'package:hey_flutter/Widget/AppLogoLogin.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/StatusBarCleaner.dart';
import '../Widget/Theme.dart';
import 'LoginPage.dart';
import 'RegistrationPage.dart';

class LRPage extends StatefulWidget {
  LRPage({Key key}) : super(key: key);

  @override
  LRPageState createState() => new LRPageState();
}

class LRPageState extends State<LRPage> with SingleTickerProviderStateMixin {

  GlobalKey registrationButton = GlobalKey();
  GlobalKey loginButton = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StatusBarCleaner(
      image: new ExactAssetImage('assets/image/vecchia.jpeg'),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.5)]),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MoobTheme.paddingHorizontal*1.5),
                child: AppLogoLogin()
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(MoobTheme.paddingHorizontal*2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(99.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.of(context).push(CircularRevealRoute(widget: RegistrationPage(),position:getContainerPosition(registrationButton)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal*2, vertical: 4),
                        child: Text(
                          "Registrati",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      key: registrationButton,
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      height: 1,
                    ),
                    SizedBox(height: 40),
                    Text("Hai già un account?", style: TextStyle(color: Colors.white),),
                    SizedBox(height: 20),
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(99.0),
                        side: BorderSide(color: MoobTheme.mainColor),
                      ),
                      color: MoobTheme.mainColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.of(context).push(CircularRevealRoute(widget: LoginPage(),position:getContainerPosition(loginButton)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: MoobTheme.paddingHorizontal, vertical: 4),
                        child: Text(
                          "Accedi",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      key: loginButton,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}