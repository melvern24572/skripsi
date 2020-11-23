import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './components/drawer.dart';
import 'components/constrant.dart' as constrant;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Prediction extends StatefulWidget {
  static const String routeName = '/prediction';
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  String katval;
  List _kategori = [
    'Laptop Asus X Series',
    'Notebook Ideapad S Series',
    'Laptop Dell Inspiron Series',
    'Laptop Lenovo V Series',
    'Intel Core i3',
    'Intel Core i5',
    'Intel Core i7',
    'AMD Ryzen',
    'FlashDisk 16GB',
    'FlashDisk 32GB',
    'Webcam',
    'Ram DDR 3 4 GB',
    'Ram DDR 3 8 GB',
    'Ram DDR 3 16 GB',
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
  var hasil_a, hasil_b, hasil_nilai;
  var indexAwal;
  var indexAkhir;
  String bulanawal;
  String bulanakhir;
  List data = List();
  List prediksi = List();
  List hitung = List();
  Future<String> getData() async {
    var url = '${constrant.url}/getAllBarang.php';
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print('data : $data');
    return 'Sucess';
  }

  Future getPrediksi() async {
    var url = "${constrant.url}/getPrediksi.php";
    var response = await http.post(url, body: {
      "bulan_awal": indexAwal.toString(),
      "bulan_akhir": indexAkhir.toString(),
      "kategori_barang": katval,
    }, headers: {
      "Accept": "application/json"
    });
    var resBody = json.decode(response.body);

    setState(() {
      prediksi = resBody;
    });

    //print('total: $transaksi');
    return "Sucess";
  }
  Future getHitung() async {
    var url = "${constrant.url}/getHitung.php";
    var response = await http.post(url, body: {
      "bulan_awal": indexAwal.toString(),
      "bulan_akhir": indexAkhir.toString(),
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
  void initState() {
    super.initState();
    this.getData();
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
        children: [
          Row(
            children: [
              Text('Pilih Barang : '),
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dari bulan '),
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
                      print(bulanawal);
                      indexAwal = months.indexOf(value) + 1;
                      print(indexAwal);
                    });
                  },
                );
              }),
              Text('Sampai bulan '),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return DropdownButton(
                  hint: Text('Dari Bulan'),
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
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: hitung.length,
                itemBuilder: (context, index) {
                  return
                    Container(
                      child: Row(
                        children: [
                          Text(hitung[index]['bulan']),
                          Text(hitung[index]['kategori_barang']),
                          Text(hitung[index]['y']),
                          Text(hitung[index]['x']),
                          Text(hitung[index]['xy']),
                          Text(hitung[index]['x2']),
                        ],
                      ),
                    );
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: prediksi.length,
                itemBuilder: (context, index) {
                  a = double.parse(prediksi[index]['a']);
                  b = double.parse(prediksi[index]['b']);
                  nilai = double.parse(prediksi[index]['prediksi']);
                  hasil_a = a.round();
                  hasil_b = b.round();
                  hasil_nilai = nilai.round();
                  return
                    Row(
                      children: [
                        Text(hasil_a.toString()),
                        Text(hasil_b.toString()),
                        Text(hasil_nilai.toString()),
                      ],
                    );


                }),
          ),
        ],
      ),
    );
  }
}
