import 'package:flutter/material.dart';
import 'package:heiserver_connector/Structure/TagClass.dart';

class UtilityTools{

  static String DayNumberToShortString(int i){
    List<String> giorno = ["Lun","Mar","Mer","Gio","Ven","Sab","Dom"];

    return giorno[i-1];
  }

  static String MonthNumberToLongString(int i){
    List<String> mese = ["Gennaio","Febraio","Marzo","Aprile","Maggio","Giugno","Luglio","Agosto","Settembre","Ottobre","Novembre","Dicembre"];

    return mese[i-1];
  }

  static TagToIcons(Tag tag){
    switch (tag.tag){
      case "Musica":
        return Icons.music_note;
      case "Cibo":
        return Icons.fastfood;
      case "Sport":
        return Icons.directions_run;
    }
  }
}