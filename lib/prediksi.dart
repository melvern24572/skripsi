import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/drawer.dart';
import 'components/constrant.dart' as constrant;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'components/line_chart.dart';

class Prediction extends StatefulWidget {
  static const String routeName = '/prediction';
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  ScrollController _scrollController = new ScrollController();
  String katval;
  List tahun = [
    '2020',
    '2021',
  ];
  List _kategori = [
    'Laptop Asus X Series',
    'Notebook Ideapad S Series',
    'Laptop Dell Inspiron Series',
    'Laptop Lenovo V Series',
    'Intel Core i3',
    'Intel Core i5',
    'AMD Ryzen',
    'FlashDisk 16GB',
    'FlashDisk 32GB',
    'Webcam',
    'Ram DDR 3 4 GB',
    'Ram DDR 3 8 GB',
    'Ram DDR 4 4 GB',
    'Ram DDR 4 8 GB',
    'Ram DDR 4 16 GB',
  ];
  var months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  double a,b, nilai;
  // ignore: non_constant_identifier_names
  var hasil_a, hasil_b, hasil_nilai;
  var indexAwal;
  var indexAkhir;
  String bulanawal;
  String bulanakhir;
  String tahunawal;
  String tahunakhir;
  List data = List();
  List prediksi = List();
  List hitung = List();

  Future getPrediksi() async {
    var url = "${constrant.url}/getPrediksi.php";
    var response = await http.post(url, body: {
      "bulan_awal": indexAwal.toString(),
      "bulan_akhir": indexAkhir.toString(),
      "tahun_awal" : tahunawal.toString(),
      "tahun_akhir" : tahunakhir.toString(),
      "kategori_barang": katval,
    }, headers: {
      "Accept": "application/json"
    });
    var resBody = json.decode(response.body);

    setState(() {
      prediksi = resBody;
    });
    return "Sucess";
  }

  Future getHitung() async {
    var url = "${constrant.url}/getHitung.php";
    var response = await http.post(url, body: {
      "bulan_awal": indexAwal.toString(),
      "bulan_akhir": indexAkhir.toString(),
      "tahun_awal" : tahunawal.toString(),
      "tahun_akhir" : tahunakhir.toString(),
      "kategori_barang": katval,
    }, headers: {
      "Accept": "application/json"
    });
    print(indexAwal);
    print(indexAkhir);

    var resBody = json.decode(response.body);

    setState(() {
      hitung = resBody;
    });
    print("test: $hitung");
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Prediksi'),
      ),
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButton(
                    hint: Text('Pilih Kategori'),
                    value: katval,
                    onChanged: (value) {
                      setState(() {
                        katval = value;
                        print(value);
                      });
                    },
                    items: _kategori.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return DropdownButton(
                  hint: Text('Bulan'),
                  value: bulanawal,
                  items: months.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      bulanawal = value;
                      indexAwal = months.indexOf(value) + 1;
                    });
                  },
                );
              }),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButton(
                      hint: Text('Tahun'),
                      value: tahunawal,
                      items: tahun.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          tahunawal = value;
                          print('tahun: $tahunawal');
                        });
                      },
                    );
                  }),
              Text(' -> '),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return DropdownButton(
                  hint: Text('Bulan'),
                  value: bulanakhir,
                  items: months.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      bulanakhir = value;
                      indexAkhir = months.indexOf(value) + 1;
                      print(indexAkhir);
                    });
                  },
                );
              }),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButton(
                      hint: Text('Tahun'),
                      value: tahunakhir,
                      items: tahun.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          tahunakhir = value;
                          print('tahun: $tahunakhir');
                        });
                      },
                    );
                  }),
            ],
          ),
          RaisedButton(
            onPressed: () async {
              setState(() {
                getHitung();
                getPrediksi();
              });
            },
            child: Text("Submit"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
          ),
          LineChartComponent(),
//          Container(
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(25)),
//                color: Colors.deepPurple),
//            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                header("No"),
//                header("Tahun"),
//                header("Bulan"),
//                header("Kategori Barang"),
//                header("Y"),
//                header("X"),
//                header("XY"),
//                header("X2"),
//              ],
//            ),
//          ),
//          Container(
//            child: ListView.builder(
//              controller: _scrollController,
//                shrinkWrap: true,
//                itemCount: hitung.length,
//                itemBuilder: (context, index) {
//                  return
//                    Container(
//                      child: Row(
//                        children: [
//                          body(hitung[index]['no']),
//                          body(hitung[index]['tahun']),
//                          body(hitung[index]['bulan']),
//                          body(hitung[index]['kategori_barang']),
//                          body(hitung[index]['y']),
//                          body(hitung[index]['x']),
//                          body(hitung[index]['xy']),
//                          body(hitung[index]['x2']),
//                        ],
//                      ),
//                    );
//                }),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 8.0),
//          ),
//          Container(
//            child: ListView.builder(
//              controller: _scrollController,
//                shrinkWrap: true,
//                itemCount: prediksi.length,
//                itemBuilder: (context, index) {
//                  a = double.parse(prediksi[index]['a']);
//                  b = double.parse(prediksi[index]['b']);
//                  nilai = double.parse(prediksi[index]['prediksi']);
//                  hasil_a = a.round();
//                  hasil_b = b.round();
//                  hasil_nilai = nilai.round();
//                  if(hasil_nilai < 0){
//                    hasil_nilai = 0;
//                  }
//                  return
//                    Column(
//                      children: [
//                        Row(
//                          children: [
//                            Text("nilai a : "),
//                            Text(hasil_a.toString()),
//                          ],
//                        ),
//                        Row(
//                          children: [
//                            Text("nilai b : "),
//                            Text(hasil_b.toString()),
//                          ],
//                        ),
//                        Row(
//                          children: [
//                            Text("nilai prediksi : "),
//                            Text(hasil_nilai.toString()),
//                          ],
//                        ),
//                      ],
//                    );
//                }),
//          ),
        ],
      ),
    );
  }

}

Widget header(String name){
  return Expanded(
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,

      ),
    ),
  );
}
Widget body(String name){
  return Expanded(
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}


