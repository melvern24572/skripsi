import 'package:flutter/material.dart';
import 'components/drawer.dart';
import 'components/routes.dart';
import 'components/gridview_card.dart';
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
                GridViewCard(tahun: "Juli", ontap: () => Navigator.pushReplacementNamed(context, Routes.listTransaksi), controller: month ,),
                GridViewCard(tahun: "Agustus", ontap: () => Navigator.pushReplacementNamed(context, Routes.listTransaksi), controller: month ,),
                GridViewCard(tahun: "September", ontap: () => Navigator.pushReplacementNamed(context, Routes.listTransaksi), controller: month ,),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

          });
        },
      ),
    );
  }
}


