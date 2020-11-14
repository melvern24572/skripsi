import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi/components/drawer.dart';
import 'dart:convert';
import 'components/constrant.dart' as constrant;
class PageBarang extends StatefulWidget {
  static const String routeName = '/barang';
  @override
  _PageBarangState createState() => _PageBarangState();
}

class _PageBarangState extends State<PageBarang> {
  bool showSpinner;
  String katval;
  List _kategori = [
    'Laptop Asus X Series',
    'Notebook Ideapad S Series',
    'Asus ROG Series',
    'Laptop Dell Inspiron Series',
    'Laptop Lenovo Series',
    'Intel Core i5',
    'Intel Core i7',
    'AMD Ryzen',
    'FlashDisk 16GB',
    'FlashDisk 32GB',
    'Webcam'
  ];
  TextEditingController namaBarang = TextEditingController();
  TextEditingController updateBarang = TextEditingController();
  Future addData() async {
    var url = "${constrant.url}/createBarang.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "nama_barang": namaBarang.text,
      "kategori_barang": katval,
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

  Future getData() async {
    var url = '${constrant.url}/getAllBarang.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  Future editData(var idBarang) async{
    var url = "${constrant.url}/updateBarang.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "id_barang": idBarang,
      "nama_barang": updateBarang.text,
      "kategori_barang": katval,
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
        msg: "Update Failed",
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

  Future deleteData(var idBarang) async {
    var url = "${constrant.url}/deleteBarang.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "id_barang": idBarang,
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
        msg: "Delete Failed",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Barang'),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return ListTile(
                      leading: Text(list[index]['id_barang']),
                      title: Text(list[index]['nama_barang']),
                      subtitle: Text(list[index]['kategori_barang']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.edit),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return AlertDialog(
                                        content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    decoration: (InputDecoration(
                                                        hintText: 'Nama Barang')),
                                                    controller: updateBarang,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(6.0),
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
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        child: Text("Cancel"),
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      Spacer(
                                                        flex: 5,
                                                      ),
                                                      RaisedButton(
                                                        color: Colors.green,
                                                        child: Text("Submit"),
                                                        onPressed: () async {
                                                          editData(list[index]['id_barang']);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                                  });
                            },
                          ),
                          GestureDetector(
                            child: Icon(Icons.delete),
                            onTap: () async {
                              showDialog(
                                  context: context,
                              builder: (BuildContext context){
                                    return AlertDialog(
                                      content: Stack(
                                        overflow: Overflow.visible,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Are you sure want to delete it ?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    RaisedButton(
                                                      child: Text("NO"),
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    Spacer(
                                                      flex: 5,
                                                    ),
                                                    RaisedButton(
                                                      color: Colors.green,
                                                      child: Text("YES"),
                                                      onPressed: () async {
                                                        deleteData(list[index]['id_barang']);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                              },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration:
                                    (InputDecoration(hintText: 'Nama Barang')),
                                controller: namaBarang,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6.0),
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
                                      addData();
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
                });
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
