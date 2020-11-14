import 'package:skripsi/barang.dart';
import 'package:skripsi/login_screen.dart';

import '../home.dart';
import '../prediksi.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/list_transaksi.dart';

class Routes{
  static const String home = Home.routeName;
  static const String prediksi = Prediction.routeName;
  static const String login = LoginScreen.routeName;
  static const String listTransaksi = ListTransaksi.routeName;
  static const String barang = PageBarang.routeName;
  static getRoutes(BuildContext context){
    return{
      login: (context) => LoginScreen(),
      home: (context) => Home(),
      prediksi :(context) => Prediction(),
      listTransaksi : (context) => ListTransaksi(),
      barang : (context) => PageBarang(),
    };
  }
}