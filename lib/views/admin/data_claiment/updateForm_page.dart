import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class updateDataClaiment extends StatelessWidget {
  const updateDataClaiment({
    Key? key,
    required this.id,
    required this.nama_lengkap_old,
    required this.alamat_old,
    required this.no_tlp_old,
  }) : super(key: key);
  final int id;
  final String nama_lengkap_old;
  final String alamat_old;
  final String no_tlp_old;
  @override
  Widget build(BuildContext context) {
    TextEditingController nama_lengkap = TextEditingController();
    TextEditingController alamat = TextEditingController();
    TextEditingController no_tlp = TextEditingController();
    nama_lengkap.text = nama_lengkap_old;
    alamat.text = alamat_old;
    no_tlp.text = no_tlp_old;

    // nama_lengkap.text = id.toString();
    Color? color_input = Colors.black;
    Color? apps_appbar = Colors.blue[300];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: apps_appbar,
        title: Text('Ubah Data'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Lengkap',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color_input),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  maxLength: 100,
                  onChanged: (value) {},
                  controller: nama_lengkap,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alamat',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color_input),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  maxLength: 100,
                  onChanged: (value) {},
                  controller: alamat,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alamat',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color_input),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  // borderRadius: BorderRadius.all(Radius.circular(20)),
                  maxLength: 12,
                  onChanged: (value) {},
                  controller: no_tlp,
                ),
              ],
            ),
            Container(
                child: FlatButton(onPressed: () {}, child: Text('UBAH DATA'))),
          ],
        ),
      ),
    );
  }
}
