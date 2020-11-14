import 'package:flutter/material.dart';
import 'components/constrant.dart' as constrant;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListTransaksi extends StatefulWidget {
  final String bulan;
  final String tahun;

  const ListTransaksi({
    Key key,
    @required this.bulan,
    @required this.tahun,
  }) : super(key: key);

  static const String routeName = '/listTransaksi';
  @override
  _State createState() => _State();
}

class _State extends State<ListTransaksi> {
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
  List  transaksi = List();

  Future getTransaksi() async {
    var url = "${constrant.url}/getTransaksiByMonthAndYear.php";
    var response = await http.post(url, body: {
      "bulan": widget.bulan.toString(),
      "tahun": widget.tahun.toString(),
    },headers: {"Accept": "application/json"});
    var resBody = json.decode(response.body);
    print('transaksi : $resBody');
    setState(() {
      transaksi = resBody;
    });

    //print('total: $transaksi');
    return "Sucess";
  }
  @override
  void initState() {
    super.initState();
    this.getTransaksi();
  }
  @override
  Widget build(BuildContext context) {
//    print('bulan : ${widget.bulan}');
//    print('tahun :${}widget.tahun');
    return Scaffold(
      appBar: AppBar(
        title: Text(months[int.parse(widget.bulan)]),
      ),
      body: ListView.builder(itemCount: transaksi.length, itemBuilder: (context, index) {
            return ListTile(
              leading: Text(transaksi[index]['id_transaksi']),
              title: Text(transaksi[index]['nama_barang']),
              subtitle: Text(transaksi[index]['kategori_barang']),
              trailing: Text(transaksi[index]['jumlah']),
            );
          })
    );
  }
}
