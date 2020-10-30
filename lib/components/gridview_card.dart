import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  final ontap;
  final String tahun;
  final TextEditingController controller;

  const GridViewCard({
    Key key,
    @required this.ontap,
    @required this.tahun,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              tahun,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: controller,
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}