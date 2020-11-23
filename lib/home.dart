import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skripsi/components/bar_chart.dart';
import 'package:skripsi/utils/function.dart';
import 'components/drawer.dart';
import 'package:skripsi/components/constrant.dart' as constrant;
import 'components/gridview_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'list_transaksi.dart';

class TransaksiSummary {}

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
  var months = [
    "",
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

    print('total: $total');
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

  Future addTransaction() async {
    var url = "${constrant.url}/createTransaksi.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "id_barang": _mySelection,
      "jumlah": qty.text,
      "tanggal": _dateTime.day.toString(),
      "bulan": _dateTime.month.toString(),
      "tahun": _dateTime.year.toString(),
    });
    var data = json.decode(response.body);

    Functions.toast(msg: data == "success" ? "success" : "Input Failed");
    if (data == "success") Navigator.of(context).pop();

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
    //setDummyData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan'),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "2020",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            BarChartComponent(
              jumlah: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This Month Sales",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Text(
                    "Nov 2020",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                "Total: 56 transactions",
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text("Top sales: Leptop Lenovo"),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: total.length,
              itemBuilder: (context, i) => GridViewCard(
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListTransaksi(
                              bulan: total[i]['bulan'],
                              tahun: total[i]['tahun'],
                            )),
                  );
                },
                bulan: months[int.parse(total[i]['bulan'])],
                total: total[i]['total'],
              ),
            ),
          ],
        ),
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
                                      Text(_dateTime == null
                                          ? 'Masukkan tanggal'
                                          : _dateTime.toString()),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.calendar_today),
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2020),
                                                  lastDate: DateTime(2021))
                                              .then((date) {
                                            setState(() {
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
                                        hintText: "Masukkan Jumlah Barang"),
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

  void setDummyData() {
    total = [
      {"total": "10", "bulan": "1", "tahun": "2020"},
      {"total": "20", "bulan": "2", "tahun": "2020"},
      {"total": "30", "bulan": "3", "tahun": "2020"},
      {"total": "30", "bulan": "3", "tahun": "2020"},
      {"total": "30", "bulan": "3", "tahun": "2020"},
      {"total": "30", "bulan": "3", "tahun": "2020"},
    ];
  }
}
