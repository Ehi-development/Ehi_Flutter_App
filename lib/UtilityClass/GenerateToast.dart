import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

GenerateToast(message){
  return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
}