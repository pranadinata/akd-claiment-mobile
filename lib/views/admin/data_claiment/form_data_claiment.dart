import 'dart:ui';

import 'package:akd_flutter/models/api_route.dart';
import 'package:flutter/material.dart';
import 'package:akd_flutter/controllers/post_data_claiment.dart';

class formDataClaiment extends StatefulWidget {
  @override
  _formDataClaimentState createState() => _formDataClaimentState();
}

class _formDataClaimentState extends State<formDataClaiment> {
  TextEditingController nama_lengkap = TextEditingController();
  TextEditingController alamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color? color_input = Colors.black;
    Color? apps_appbar = Colors.blue[300];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: apps_appbar,
          title: Text("Data Claiment"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    PostDataClaiment.connectToAPI(
                        nama_lengkap.text.toString(), alamat.toString());
                    // print(DATA_CLAIMENT_STORE);
                  },
                  child: Icon(Icons.add
                      // size: 26.0,
                      ),
                )),
          ],
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
                          fontFamily: "Aller",
                          fontSize: 17,
                          color: color_input),
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
                    onChanged: (value) {
                      setState(() {
                        // print(MediaQuery.of(context).size.height * 0.3);
                      });
                    },
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
                          fontFamily: "Aller",
                          fontSize: 17,
                          color: Colors.black),
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
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: alamat,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
