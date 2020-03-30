import 'package:flutter/material.dart';
import 'dart:io';

class FragmentManager {
  var context;
  static var staticContext;

  String username;
  static FragmentManager fragmentManager;

  static List<Widget> allFragment = [];

  static List refreshedList = [];

  FragmentManager(this.context){
    refreshedList.add(context);
    staticContext = context;
  }

  static addToRefreshList(item){
    refreshedList.add(item);
  }

  static setFragmentManager(FM){
    fragmentManager=FM;
  }

  static FragmentManager getFragmentManager(){
    return fragmentManager;
  }

  getContext(){
    return staticContext;
  }

  refresh(){
    for (var item in refreshedList) {
      item.setState(() {});
    }
  }

  home(Widget fragment){
    if(allFragment.isEmpty){
      allFragment.add(fragment);
    }
  }

  previusFragment(){
    allFragment.removeLast();
    if(allFragment.isEmpty)
      exit(0);
    else
      fragmentManager.refresh();
  }

  String nowLoading(){
    return allFragment.last.toString();
  }

  routeTo(Widget fragment){
    //if(allFragment.last!=fragment){
      allFragment.add(fragment);
      fragmentManager.refresh();
    //}
  }

  Widget deployHere() {
    print(allFragment.last.toString());
    return allFragment.last;
  }
}