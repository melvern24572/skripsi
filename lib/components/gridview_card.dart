import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  final Function ontap;
  final String bulan;
  final String total;
  final String tahun;
  const GridViewCard({
    Key key,
    @required this.ontap,
    @required this.bulan, this.total, this.tahun,

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
              bulan,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(total, style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}