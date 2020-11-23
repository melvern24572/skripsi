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
  List transaksi = List();

  Future getTransaksi() async {
    var url = "${constrant.url}/getTransaksiByMonthAndYear.php";
    var response = await http.post(url, body: {
      "bulan": widget.bulan.toString(),
      "tahun": widget.tahun.toString(),
    }, headers: {
      "Accept": "application/json"
    });
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
    //setDummyData();

    return Scaffold(
        appBar: AppBar(
          title: Text(months[int.parse(widget.bulan)]),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.deepPurple),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      header("ID Transaksi"),
                      header("Nama Barang"),
                      header("Kategori Barang"),
                      header("Jumlah"),
                    ],
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: transaksi.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            body(transaksi[index]['id_transaksi']),
                            body(transaksi[index]['nama_barang']),
                            body(transaksi[index]['kategori_barang']),
                            body(transaksi[index]['jumlah']),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }

//  void setDummyData() {
//    transaksi = [
//      {
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },
//      {
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },
//      {
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },
//      {
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },{
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      },
//      {
//        "id_transaksi": "1",
//        "nama_barang": "Lenovo FX505GE",
//        "kategori_barang": "Laptop Lenovo",
//        "jumlah": "8"
//      }
//    ];
//  }

  Widget header(String name){
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,

        ),
      ),
    );
  }

  Widget body(String name){
    return Expanded(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
