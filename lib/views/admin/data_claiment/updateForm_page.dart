import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//package tambahan 
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/controllers/post_data_claiment.dart';

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


    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.MBase,
        title: Text('Data Klaiment'),
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
                        fontFamily: "Aller", fontSize: 17, color: color.MInputName),
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
                        fontFamily: "Aller", fontSize: 17, color: color.MInputName),
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
                        fontFamily: "Aller", fontSize: 17, color: color.MInputName),
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
              margin: EdgeInsets.only(top: 10),
              width: setting.widthFlex(context),
              child: ElevatedButton(
                onPressed: () {
                  updatePostDataKlaiment.connectToAPI(
                    nama_lengkap.text.toString(), alamat.text.toString(), no_tlp.text.toString(), id.toString()
                  );
                  final snackBar = SnackBar(content: Text('Berhasil mengubah data'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context, (){});
                },
                child: Text(
                  'Ubah Data',
                  style: new TextStyle(
                    fontSize: 20.0,
                    // color: Colors.yellow,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: color.MBase,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // <-- Radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
