import 'package:flutter/material.dart';
import 'package:heiserver_connector/Implementation/User.dart';
import 'package:heiserver_connector/Structure/UserClass.dart';
import 'package:heiserver_connector/Utility/LocalLoginData.dart';
import 'package:hey_flutter/Pages/AddDetailPage.dart';
import 'package:hey_flutter/Pages/RegistrationResultPage.dart';
import 'package:hey_flutter/Widget/ProgressButton.dart';

import '../Widget/GenerateToast.dart';
import 'RouteBuilder.dart';

class ContactServerWithAlert {

  static checkLogin({ @required context,
                      GlobalKey<ProgressButtonState> ProgressButtonKey,
                      @required username,
                      @required password}) async {

    if(ProgressButtonKey!=null){ProgressButtonKey.currentState.progress();}

    var result =await User().loginUser(username,password);
    if(result==0){
      LocalLoginData.login(username,password);
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.done();}
      return 0;
    }else if(result==1){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("Ti invitiamo a riprovare");
      /*showFlushbar(context:context,title:"Username o Password errati",message:"",icon:Icons.error_outline);*/
    }else if(result==2){
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("Account non verificato");
      /*showFlushbar(context:context,title:"",message:"Controlla la tua mail",icon:Icons.error_outline);*/
    }else{
      GenerateToast("Connessione interrotta");
      if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      /*showFlushbar(context:context,title:"",message:"Probabilmente i nostri server hanno un problema",icon:Icons.error_outline);*/
    }
    return 1;
  }

  static newUserRegistration({
    @required context,
    GlobalKey<ProgressButtonState> ProgressButtonKey,
    @required UserClass user,
  }) async {

    if (ProgressButtonKey != null) {
      ProgressButtonKey.currentState.progress();
    }

    if (user.username == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("Lo username non può essere nullo");
    } else if (user.username.contains(" ")) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("Lo username non può contenere spazi vuoti");
    } else if (user.name == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("Il Nome utente non può essere nullo");
    } else if (user.surname == null) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("Il Cognome non può essere nullo");
    } else if (user.email!=null && user.email.contains(' ')) {
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("La mail non può contenere spazi vuoti");
    } else if(user.email!=null && !user.email.contains("@") && !user.email.contains(".")){
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("Inserire una mail valida");
    }else if(user.birth==null){
      if (ProgressButtonKey != null) {
        ProgressButtonKey.currentState.error();
      }
      GenerateToast("La tua data di nascita non può essere nulla");
    }else {
      User().registerUser(user).then((result) async {
        if (result == 0) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.done();
          }

          Navigator.of(context).pushReplacement(CircularRevealRoute(widget: RegistrationResultPage(),position:getContainerPosition(ProgressButtonKey)));

          return 0;
        } else if (result == 1) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }
          GenerateToast("Ti invitiamo a sceglierne un altro");
          return 1;
        }else if (result == 2) {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }
          GenerateToast("La mail che hai inserito è già utilizzata");
          return 2;
        } else {
          if (ProgressButtonKey != null) {
            ProgressButtonKey.currentState.error();
          }
          GenerateToast("Probabilmente i nostri server hanno un problema");
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

    //if(ProgressButtonKey!=null && buttonPressed==null){buttonPressed=ProgressButtonKey;}
    //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.progress();}

    if(username==null){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("Lo username non può essere nullo");
    }else if(username.contains(" ")){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("Lo username non può avere spazi vuoti");
    }else if(password==null){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("La password non può essere nulla");
    }else if(password.length<8){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("La password è troppo corta \n Minimo 6 caratteri");
    }else if(password.length>16){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("La password è troppo lunga \n Massimo 16 caratteri");
    }else if(password!=repeatPassword){
      //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
      GenerateToast("Le due passwords non coincidono");
    }else{
      User().fromServer(username).then((result){
        if(result.result==1){
          Navigator.of(context).pushReplacement(CircularRevealRoute(widget: AddDetailPage(username: username, password: password,),position:getContainerPosition(ProgressButtonKey)));
        }else{
          //if(ProgressButtonKey!=null){ProgressButtonKey.currentState.error();}
          GenerateToast("Username già esistente");
        }
      });
    }
  }
}