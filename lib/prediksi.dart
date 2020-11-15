import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/wangs/AndroidStudioProjects/skripsi/lib/components/drawer.dart';
import 'components/constrant.dart' as constrant;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Prediction extends StatefulWidget {
  static const String routeName = '/prediction';
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
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
  var indexAwal;
  var indexAkhir;
  String bulanawal;
  String bulanakhir;
  List data = List();
  List prediksi = List();
  String _mySelection;
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
    var response = await http.post(url,
        body: {
          "bulan_awal": indexAwal.toString(),
          "bulan_akhir": indexAkhir.toString(),
          "kategori_barang" : _mySelection,},
        headers: {"Accept": "application/json"});
    var resBody = json.decode(response.body);
    print('transaksi : $resBody');
    setState(() {
     prediksi = resBody;
    });

    //print('total: $transaksi');
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
                    hint: Text('Pilih Barang'),
                    value: _mySelection,
                    onChanged: (value) {
                      setState(() {
                        _mySelection = value;
                      });
                    },
                    items: data.map((item) {
                      return DropdownMenuItem(
                        child: new Text(item['kategori_barang']),
                        value: item['id_barang'],
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
                getPrediksi();
              });
            },
            child: Text("Submit"),
          ),
          Spacer(
            flex: 5,
          ),
          Expanded(
            child: ListView.builder(itemCount: prediksi.length, itemBuilder: (context, index) {
              return ListTile(
                leading: Text(prediksi[index]['a']),
                subtitle: Text(prediksi[index]['b']),
                trailing: Text(prediksi[index]['prediksi']),
              );
            }),
          )
        ],
      ),
    );
  }
}
