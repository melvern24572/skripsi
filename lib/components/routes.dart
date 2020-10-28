import 'package:skripsi/login_screen.dart';

import '../home.dart';
import '../prediksi.dart';
import 'package:flutter/material.dart';
import '../lastyear.dart';

class Routes{
  static const String home = Home.routeName;
  static const String prediksi = Prediction.routeName;
  static const String login = LoginScreen.routeName;
  static const String lastyear = LastYear.routeName;
  static getRoutes(BuildContext context){
    return{
      login: (context) => LoginScreen(),
      home: (context) => Home(),
      prediksi :(context) => Prediction(),
      lastyear : (context) => LastYear(),
    };
  }
}