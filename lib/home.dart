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
  String total;
  String _mySelection;
  List data = List();

  Future<String> getTotal() async {
    var url = "http://192.168.42.191/prediksi/getTransaksiSummary.php";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      total = resBody;
    });
    print(total);
    return "Sucess";
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

  Future addTransaction ()async{
    var url = "http://192.168.42.191/prediksi/createTransaksi.php";
    setState(() {
      showSpinner = true;
    });
    print(_mySelection);
    print(qty.text);
    print(_dateTime.day);
    print(_dateTime.month);
    print(_dateTime.year);
    var response = await http.post(url, body: {
      "id_barang": _mySelection,
      "jumlah": qty.text,
      "tanggal" : _dateTime.day.toString(),
      "bulan" : _dateTime.month.toString(),
      "tahun" : _dateTime.year.toString(),
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
    this.getTotal();
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
            total: getTotal().toString(),
           bulan: "Juli",
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
          ),
          GridViewCard(
            bulan: "Agustus",
            total: getTotal().toString(),
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
          ),
          GridViewCard(
            total: getTotal().toString(),
            bulan: "September",
            ontap: () =>
                Navigator.pushReplacementNamed(context, Routes.listTransaksi),
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
                                        value: item['id_barang'],
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
                                          addTransaction();
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
