import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'constrant.dart' as constrant;
import 'package:http/http.dart' as http;
import 'dart:convert';
class BarChartComponent extends StatefulWidget {
  final double jumlah;
  const BarChartComponent({ this.jumlah});
  @override
  _BarChartComponentState createState() => _BarChartComponentState();
}

class _BarChartComponentState extends State<BarChartComponent> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  List total = List();
  int touchedIndex;
  bool isPlaying = false;

  Future getTotal() async {
    var url = "${constrant.url}/getTransaksiSummary.php";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      total = resBody;
    });

    print('total: $total');
    return "Sucess";
  }

  double getJumlahByBulan(int bulan){
    getTotal();
    print(total.length);
    for (int i =0; i< total.length; i++){
      print('bulan :${total[i]['bulan']}');
      print('test : $bulan');
      if(total[i]['bulan'] == bulan){
        return total[i]['total'];
      }



    }
    return 0;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: BarChart(
          mainBarData(),
          swapAnimationDuration: animDuration,
        )
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Januari';
                  break;
                case 1:
                  weekDay = 'Februari';
                  break;
                case 2:
                  weekDay = 'Maret';
                  break;
                case 3:
                  weekDay = 'April';
                  break;
                case 4:
                  weekDay = 'Mei';
                  break;
                case 5:
                  weekDay = 'Juni';
                  break;
                case 6:
                  weekDay = 'Juli';
                  break;
                case 7:
                  weekDay = 'Agustus';
                  break;
                case 8:
                  weekDay = 'September';
                  break;
                case 9:
                  weekDay = 'Oktober';
                  break;
                case 10:
                  weekDay = 'November';
                  break;
                case 11:
                  weekDay = 'Desember';
                  break;
              }
              return BarTooltipItem(
                  weekDay + '\n' + (rod.y - 1).toString(), TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Apr';
              case 4:
                return 'Mei';
              case 5:
                return 'Jun';
              case 6:
                return 'Jul';
              case 7:
                return 'Aug';
              case 8:
                return 'Sep';
              case 9:
                return 'Oct';
              case 10:
                return 'Nov';
              case 11:
                return 'Dec';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }


  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, getJumlahByBulan(1), isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, getJumlahByBulan(2), isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, getJumlahByBulan(3), isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, getJumlahByBulan(4), isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, getJumlahByBulan(5), isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5, getJumlahByBulan(6), isTouched: i == touchedIndex);
      case 6:
        return makeGroupData(6, getJumlahByBulan(7), isTouched: i == touchedIndex);
      case 7:
        return makeGroupData(7, getJumlahByBulan(8), isTouched: i == touchedIndex);
      case 8:
        return makeGroupData(8, getJumlahByBulan(9), isTouched: i == touchedIndex);
      case 9:
        return makeGroupData(9, getJumlahByBulan(10), isTouched: i == touchedIndex);
      case 10:
        return makeGroupData(10, getJumlahByBulan(11), isTouched: i == touchedIndex);
      case 11:
        return makeGroupData(11, getJumlahByBulan(12), isTouched: i == touchedIndex);
      default:
        return null;
    }
  });

  BarChartGroupData makeGroupData(
      int x,
      double y, {
        bool isTouched = false,
        Color barColor = const Color(0xff72d8bf),
        double width = 12,
        List<int> showTooltips = const [],
      }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: false,
            y: 20,
            colors: [Colors.black12],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}

