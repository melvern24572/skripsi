import 'package:flutter/cupertino.dart';
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
        color: Colors.deepPurple,
        child: InkWell(
          splashColor: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(24),
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24))),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: <Widget>[
                Text(
                  bulan,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(": "+ total + " Transactions", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                Spacer(),
                Text("Click to see details", style: TextStyle(color: Colors.white, fontSize: 14.0, fontStyle: FontStyle.italic)),
                Icon(Icons.arrow_forward_ios_sharp, size: 14, color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}