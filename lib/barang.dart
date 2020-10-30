import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class PageBarang extends StatefulWidget {
  static const String routeName = '/barang';
  @override
  _PageBarangState createState() => _PageBarangState();
}

class _PageBarangState extends State<PageBarang> {

  Future getData()async{
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
        builder: (context,snapshot){
          if(snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                List list = snapshot.data;
                return ListTile(
                  leading: GestureDetector(child: Icon(Icons.edit),
                    onTap: (){
                    },),
                  title: Text(list[index]['nama_barang']),
                  subtitle: Text(list[index]['kategori_barang']),
                  trailing: GestureDetector(child: Icon(Icons.delete),
                    onTap: (){
                    },),
                );
              }
          )
              : CircularProgressIndicator();

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add,),
      ),
    );
  }
}
