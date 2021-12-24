import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class LineChartComponent extends StatefulWidget {
  @override
   List prediksi = List();
   List hitung = List();
   String kategori;
  LineChartComponent({Key key, this.prediksi, this.hitung, this.kategori }) : super(key: key);
  _LineChartComponentState createState() => _LineChartComponentState();
}


class _LineChartComponentState extends State<LineChartComponent> {
  int nilai;
  bool isShowingMainData;
  List total = List();
  int test;
  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }
  String getBulan(int bulan){
    if(bulan == 1)
      return "Jan";
    else if(bulan == 2)
      return "Feb";
    else if(bulan == 3)
      return "Mar";
    else if(bulan == 4)
      return "Apr";
    else if(bulan == 5)
      return "May";
    else if(bulan == 6)
      return "Jun";
    else if(bulan == 7)
      return "Jul";
    else if(bulan == 8)
      return "Aug";
    else if(bulan == 9)
      return "Sep";
    else if(bulan == 10)
      return "Oct";
    else if(bulan == 11)
      return "Nov";
    else if(bulan == 12)
      return "Dec";


  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 17,
                ),
                Text(
                  widget.kategori,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Monthly Sales',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                       mainLineData(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData mainLineData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.2),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 5,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 9,
          ),
          margin: 8,

          getTitles: (value) {

            setState(() {
              if(test == null)
              {
                return '';
              }else{
                test = test;
              }

            });
            if(value.toInt() == widget.hitung.length && test != null){
              String prediksi = getBulan(test+1);
              return prediksi;
            }

            test = int.parse(widget.hitung[value.toInt()]['bulan']);
            String hitung = getBulan(test);
//            return 'test';
            return hitung;

          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 20:
                return '20';
              case 40:
                return '40';
              case 60:
                return '60';
              case 80:
                return '80';
              case 100:
                return '100';
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: widget.hitung.length.toDouble(),
      maxY: 100,
      minY: 0,
      lineBarsData: linesBarData(),
    );
  }

  List<FlSpot>getSpot (List hitung, List prediksi){
    List<FlSpot> result = List();

    for(int i=0; i<hitung.length; i++){
      double a;
      a = double.parse(hitung[i]['y']);
      result.add(FlSpot(i.toDouble(), a));
    }
    if(prediksi.length > 0){
      double b;
      b = double.parse(prediksi[0]['prediksi']);
      nilai = b.round();
      if (nilai < 0){
        nilai = 0;
      }
      result.add(FlSpot(hitung.length.toDouble(), nilai.toDouble()));

    }
    if(result.length == 0)
    {
      result.add(FlSpot(0.0, 0.0));
    }
    return result;
  }

  List<LineChartBarData> linesBarData() {
    return [
      LineChartBarData(
        spots: getSpot(widget.hitung, widget.prediksi),
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0xfff03a9e),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
