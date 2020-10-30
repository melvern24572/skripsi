import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PageBarang extends StatefulWidget {
  static const String routeName = '/barang';
  @override
  _PageBarangState createState() => _PageBarangState();
}

class _PageBarangState extends State<PageBarang> {
  String _katval;
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
  TextEditingController nama_barang = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future getData() async {
    var url = 'http://192.168.42.92/prediksi/getAllBarang.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ini barang'),
      ),
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
                      leading: GestureDetector(
                        child: Icon(Icons.edit),
                        onTap: () {},
                      ),
                      title: Text(list[index]['nama_barang']),
                      subtitle: Text(list[index]['kategori_barang']),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {},
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
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -30.0,
                        top: -30.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: nama_barang,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: DropdownButton(
                                  hint: Text('Pilih Kategori'),
                                  value: _katval,
                                  onChanged: (value) {
                                    setState(() {
                                      _katval = value;
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
                                    onPressed: null,
                                    /*if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }*/
                                  ),
                                  Spacer(
                                    flex: 5,
                                  ),
                                  RaisedButton(
                                    color: Colors.green,
                                    child: Text("Submit"),
                                    onPressed: null,
                                    /*if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }*/
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
