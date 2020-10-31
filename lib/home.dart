import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/drawer.dart';
import 'components/routes.dart';
import 'components/gridview_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController qty = TextEditingController();
  DateTime selectedDate;
  TextEditingController month = TextEditingController();
  var months = ["Juli", "Agustus", "September"];
  String _mySelection;
  List data = List();

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(_selectDate);
      });
  }

  Future<String> getData() async {
    var url = "http://192.168.42.191/prediksi/getAllBarang.php";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    print(resBody);
    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

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
          GridViewCard(
            tahun: "Juli",
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
            controller: month,
          ),
          GridViewCard(
            tahun: "Agustus",
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
            controller: month,
          ),
          GridViewCard(
            tahun: "September",
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
            controller: month,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(6.0),
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
                                        child: new Text(item['nama_barang']),
                                        value: item['id_barang'].toString(),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(selectedDate == null ? 'Masukkan tanggal' : selectedDate.toString()),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.calendar_today),
                                          onTap: (){
                                            _selectDate();
                                          },

                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Masukkan Jumlah Barang"
                                    ),
                                    controller: qty,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                });
          });
        },
      ),
    );
  }
}
