import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'components/drawer.dart';
import 'package:skripsi/components/constrant.dart' as constrant;
import 'components/routes.dart';
import 'components/gridview_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'list_transaksi.dart';

class TransaksiSummary{

}
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
  List tahun = List();
  var months = ["","Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
  List total = List();
  String _mySelection;
  List list = List();
  List data = List();


  Future getTotal() async {
    var url = "${constrant.url}/getTransaksiSummary.php";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    setState(() {
      total = resBody;
    });

    print('total: $total' );
    return "Sucess";
  }

  Future<String> getData() async {
    var url = "${constrant.url}/getAllBarang.php";
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
    var url = "${constrant.url}/createTransaksi.php";
    setState(() {
      showSpinner = true;
    });
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
        title: Text('Penjualan'),
      ),
      drawer: MainDrawer(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        itemBuilder: (context, i){
          return GridViewCard(
            bulan: months[int.parse(total[i]['bulan'])],
            total: total[i]['total'].toString(),
            ontap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListTransaksi(
                  bulan: total[i]['bulan'],
                  tahun: total[i]['tahun'],
                )),
              );
            },
          );
        },
        itemCount: total.length,
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
