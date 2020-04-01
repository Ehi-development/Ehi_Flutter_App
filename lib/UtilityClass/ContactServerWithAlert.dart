import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/AddDetailPage.dart';
import 'package:hey_flutter/Pages/RegistrationPage.dart';
import 'package:hey_flutter/UtilityClass/ProgressButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginManager.dart';
import 'RouteBuilder.dart';
import 'UserClass.dart';
import 'UserServer.dart';

class ContactServerWithAlert {

  static checkLogin({ @required context,
                      GlobalKey<ProgressButtonState> ProgressButtonKey,
                      @required username,
                      @required password}) async {

    if(ProgressButtonKey!=null){ProgressButtonKey.currentState.progress();}

    var result =await UserServer.loginUser(username,password);
    if(result==0){
      Login(username,password);
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.done();}
      return 0;
    }else if(result==1){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Username o Password errati",message:"Ti invitiamo a riprovare",icon:Icons.error_outline);*/
    }else if(result==2){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Account non verificato",message:"Controlla la tua mail",icon:Icons.error_outline);*/
    }else{
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Connessione interrotta",message:"Probabilmente i nostri server hanno un problema",icon:Icons.error_outline);*/
    }
    return 1;
  }

  static newUserRegistration({
    @required context,
    GlobalKey<ProgressButtonState> ProgressButtonKey,
    UserClass user,
  }) async {

    if (ProgressButtonKey != null) {
      ProgressButtonKey.currentState.progress();
    }

    if (user.username == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Username errato",
          message: "Lo username non può essere nullo",
          icon: Icons.error_outline);*/
    } else if (user.username.contains(" ")) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Username errato",
          message: "Lo username non può contenere spazi vuoti",
          icon: Icons.error_outline);*/
    } else if (user.name == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Nome errato",
          message: "Il Nome utente non può essere nullo",
          icon: Icons.error_outline);*/
    } else if (user.surname == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Cognome errato",
          message: "Il Cognome non può essere nullo",
          icon: Icons.error_outline);*/
    } else if (user.email!=null && user.email.contains(' ')) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Email errato",
          message: "La mail non può contenere spazi vuoti",
          icon: Icons.error_outline);*/
    } else if(user.email!=null && !user.email.contains("@") && !user.email.contains(".")){
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "Email errato",
          message: "Inserire una mail valida",
          icon: Icons.error_outline);*/
    }else if(user.birth==null){
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      /*showFlushbar(context: context,
          title: "La tua data di nascita non può essere nulla",
          message: "Inserire una data di nascita valida",
          icon: Icons.error_outline);*/
    }else {
      UserServer.registerUser(
        user: user,
      ).then((result) async {
        if (result == 0) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.done();
          }

          await SharedPreferences.getInstance().then((prefs){
            prefs.setString('loggedUsername', user.username);
            prefs.setString('loggedPass', user.password);
            prefs.setString('photo', user.photo);
          });

          //showFlushbar(context:context,title:"Complimenti",message:"Sei stato correttamente registrato",icon:Icons.check_circle_outline,color: Colors.lightBlue);
          Navigator.of(context).pushReplacement(CircularRevealRoute(widget: RegistrationPage(),position:getContainerPosition(ProgressButtonKey)));

          return 0;
        } else if (result == 1) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }

          /*showFlushbar(context:context,title:"Username già utilizzato",message:"Ti invitiamo a sceglierne un altro",icon:Icons.error_outline);*/
          return 1;
        }else if (result == 2) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }

          /*showFlushbar(context:context,title:"E-mail già utilizzata",message:"Ti invitiamo a sceglierne un altra",icon:Icons.error_outline);*/
          return 2;
        } else {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }
          /*showFlushbar(context:context,title:"Connessione interrotta",message:"Probabilmente i nostri server hanno un problema",icon:Icons.error_outline);*/
          return 3;
        }
      });


    }
  }

  static checkIfUsernameExist({@required context,
    GlobalKey<ProgressButtonState> ProgressButtonKey,
    GlobalKey buttonPressed,
    @required String username,
    @required String password,
    @required String repeatPassword}) async{

    if(ProgressButtonKey!=null && buttonPressed==null){buttonPressed=ProgressButtonKey;}
    if(ProgressButtonKey!=null){ProgressButtonKey.currentState.progress();}

    if(username==null){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Username errato",message:"Lo username non può essere nullo",icon:Icons.error_outline);*/
    }else if(username.contains(" ")){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Username errato",message:"Lo username non può avere spazi vuoti",icon:Icons.error_outline);*/
    }else if(password==null){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Username errato",message:"La password non può essere nulla",icon:Icons.error_outline);*/
    }else if(password!=repeatPassword){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"Le due passwords non coincidono",message:"Ti invitiamo a riprovare",icon:Icons.error_outline);*/
    }else{
      UserServer.fromServer(username).then((result){
        if(result.result==1){
          Navigator.of(context).pushReplacement(CircularRevealRoute(widget: AddDetailPage(username: username, password: password,),position:Offset(0,0)));
        }else{
          /*showFlushbar(context:context,title:"Username già esistente",message:"Inserisci un altro username",icon:Icons.error_outline);*/
        }
      });
    }
  }
}