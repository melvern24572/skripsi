import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool showSpinner;
  TextEditingController qty = TextEditingController();
  DateTime _dateTime;
  TextEditingController month = TextEditingController();
  var months = ["Juli", "Agustus", "September"];
  String _mySelection;
  List data = List();

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

  Future getDate (var idBarang)async{
    var url = "http://192.168.42.191/prediksi/createTransaksi.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "id_barang": idBarang,
      "jumlah": qty.text,
      "tanggal" : _dateTime.day,
      "bulan" : _dateTime.month,
      "tahun" : _dateTime.year,
    });
    var data = json.decode(response.body);
    if (data == "success") {
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
        msg: "Input Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    setState(() {
      showSpinner = false;
    });
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
                                      Text(_dateTime == null ? 'Masukkan tanggal' : _dateTime.toString()),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.calendar_today),
                                          onTap: (){
                                            showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2020),
                                                lastDate: DateTime(2021)
                                            ).then((date) {
                                              setState((){
                                                _dateTime = date;
                                              });
                                            });
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      RaisedButton(
                                        child: Text("Cancel"),
                                        color: Colors.red,
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      RaisedButton(
                                        color: Colors.green,
                                        child: Text("Submit"),
                                        onPressed: () async {
                                          //TODO : disini errornya
                                          //getDate(list[index]['id_barang']);
                                        },
                                      ),
                                    ],
                                  ),
                                )
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
