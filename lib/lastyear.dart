import 'package:flutter/material.dart';

class LastYear extends StatefulWidget {
  static const String routeName = '/lastYear';
  @override
  _State createState() => _State();
}

class _State extends State<LastYear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2019'),),
    );
  }
}
