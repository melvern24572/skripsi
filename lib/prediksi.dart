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
  String bulan;
  List data = List();
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

  Future<String> getPrediksi() async{

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
                  value: bulan,
                  items: months.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      bulan = value;
                      print(bulan);
                      var index = months.indexOf(value)+1;
                      print(index);
                    });
                  },

                );
              }),

              Text('Sampai bulan '),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButton(
                      hint: Text('Dari Bulan'),
                      value: _mySelection,
                      items: months.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          _mySelection = value;
                          var index = months.indexOf(value)+1;
                          print(index);
                        });
                      },
                    );
                  }),
            ],
          ),
          RaisedButton(
            onPressed: (){},
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
