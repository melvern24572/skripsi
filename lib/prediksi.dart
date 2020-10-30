import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/wangs/AndroidStudioProjects/skripsi/lib/components/drawer.dart';
import 'components/routes.dart';
import 'components/drawer_profile.dart';

class Prediction extends StatefulWidget {
  static const String routeName = '/prediction';
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Prediksi'),
      ),
      drawer:  MainDrawer(),
    );
  }
}
