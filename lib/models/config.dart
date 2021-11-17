import 'package:flutter/material.dart';

class color{

  static Color Mblue = Colors.blueAccent.shade200;
  static Color MGreen = Colors.greenAccent.shade400;
  static Color MRed = Colors.red.shade900;
  static Color MBase = Colors.blue.shade900;
  static Color MInputName = Colors.black;
  static Color MTextField = Colors.grey.shade200;

}

class setting{
  // static double widthFlexible = MediaQuery.of(context).size.width;
  static widthFlex(context){
    double widthFlexible = MediaQuery.of(context).size.width;
    return widthFlexible;
  }
  static background_method(){
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/background_menu.jpg"), 
          fit: BoxFit.cover
          )
        );
    
  }
}