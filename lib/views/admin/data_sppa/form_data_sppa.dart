import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;

class formDataSppa extends StatefulWidget {
  const formDataSppa({Key? key}) : super(key: key);

  @override
  _formDataSppaState createState() => _formDataSppaState();
}

class _formDataSppaState extends State<formDataSppa> {
  Color? color_input = Colors.black;
  Color? apps_appbar = Colors.blue[300];
  
  TextEditingController alamat = TextEditingController();
  TextEditingController peserta1 = TextEditingController();
  TextEditingController peserta2 = TextEditingController();

  List namaDataKlaimentList= [];

  // String _valGender;
  String? _valFriends;
  List _myFriends = [
    "Clara",
    "John",
    "Rizal",
    "Steve",
    "Laurel",
    "Bernard",
    "Miechel"
  ];
 
 Future<List> getDataKlaiment() async {
    http.Response result = await http
        .get(Uri.parse(apiRoute.DATA_CLAIMENT_ALL_DATA), headers: {"Accept": "application/json"});
    // print(result.body);
    // return json.decode(result.body);
    this.setState(() {
      Map<String, dynamic> namaDataKlaimentListAll = json.decode(result.body);
       namaDataKlaimentList = namaDataKlaimentListAll["data"];
      // namaDataKlaimentList = json.decode(result.body);
    });
    // return namaDataKlaimentList;
    // print(namaDataKlaimentList);
    return namaDataKlaimentList;
    
  }
 @override
  void initState() {
    // TODO: implement initState
   getDataKlaiment();
  }
  @override
  Widget build(BuildContext context) {
    //  print(_valFriends);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: apps_appbar,
          title: Text("Data SPPA"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    // PostDataClaiment.connectToAPI(
                    //     nama_lengkap.text.toString(), alamat.text.toString());
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Aller", fontSize: 18, color: Colors.black),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(20),
                padding: EdgeInsets.only(bottom: 20),
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text("Select Your Friends"),
                  value: _valFriends,
                  items: namaDataKlaimentList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value['nama_lengkap']),
                      value: value['nama_lengkap'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valFriends = value as String?;
                      // print(_valFriends);
                    });
                  },
                ),
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
                          fontSize: 18,
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
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Peserta 1',
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
                    controller: peserta1,
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
