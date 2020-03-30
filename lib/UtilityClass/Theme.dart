import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Questa classe permette di impostare alcuni parametri che si ripetono durante il progetto
//in modo da non dover manualmente scrivere ogni volta i valori numerici

//Esempio: invece di inserire Colors.teal inserirò MoobTheme.mainColor

class MoobTheme {

  const MoobTheme();

  //Padding Orizzontale scelto come standard dei widget rispetto al bordo dello schermo
  static const double paddingHorizontal = 24.0;

  //Colori standard scelti per l'applicazione
  static const Color secondaryMainColor = const Color(0xFF9c27b0);
  static const Color mainColor = const Color(0xFF2196f3);

  static const Color darkBackgroundColor = const Color(0xFF212121);
  static const Color middleBackgroundColor = const Color(0xFF313131);
  static const Color lightBackgroundColor = const Color(0xFF424242);

  static const Color mainColorDark = const Color(0xFF424242);
  static const Color primaryAccent = const Color(0xFF424242);
  static const Color secondaryAccent = const Color(0xFF424242);
  static Color textColor = Colors.grey[700];
  static const double radius = 18.0;

  static const Color iconColor = Colors.white;

  static const primaryGradient = const LinearGradient(
    colors: const [mainColor, secondaryMainColor],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const backgroundGradient = const LinearGradient(
    colors: const [darkBackgroundColor, lightBackgroundColor],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}