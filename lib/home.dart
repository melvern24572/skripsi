import 'package:flutter/material.dart';
import './drawer.dart';
import 'components/routes.dart';
class Home extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController month = TextEditingController();
  var months = ["Juli", "Agustus", "September"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HOME'),
        ),
        drawer: MainDrawer(),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GridViewCard(tahun: "Juli", ontap: () => Navigator.pushReplacementNamed(context, Routes.lastyear), controller: month ,),
            GridViewCard(tahun: "Agustus", ontap: () => Navigator.pushReplacementNamed(context, Routes.lastyear), controller: month ,),
            GridViewCard(tahun: "September", ontap: () => Navigator.pushReplacementNamed(context, Routes.lastyear), controller: month ,),
          ],
        ),
    );
  }
}

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
