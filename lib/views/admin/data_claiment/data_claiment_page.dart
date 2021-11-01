import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/models/preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class DataClaiment extends StatefulWidget {
  @override
  _DataClaimentState createState() => _DataClaimentState();
}

class _DataClaimentState extends State<DataClaiment> {
  //inisialisasi list ke dalam array
  List<Widget> data_claiment = [];
  List dataJson = [];
  late Future<List> dataLaporan;
  late List<bool> _isExpanded;

  Future<List> fetchData() async {
    PreferencesUser preferencesUser1 = await PreferencesUser();
    var user_id = await preferencesUser1.getUser("id");
    String urlAllDataClaiment = apiRoute.DATA_CLAIMENT_ALL_DATA;
    http.Response result = await http.post(Uri.parse(urlAllDataClaiment),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
    Map dataAll = json.decode(result.body); 
    dataJson = dataAll["data"];
    _isExpanded = new List<bool>.generate(dataJson.length, (i) => false);
    return dataJson;
  }
  //method card
  buildCard() {
    if (dataJson.isEmpty) {
        return Text('Tidak ada data');
    } else {
      return Column(children: List.generate(dataJson.length, (index) => Card(
          child: ListTile(
            title: Text(dataJson[index]['nama_lengkap']),
            subtitle: Text(dataJson[index]['alamat'])
          ),
          elevation: 8,
          shadowColor: Colors.blue,
          margin: EdgeInsets.all(5),
        )),
    );
    }
    
  }

  @override
  void initState() {
    // TODO: implement initState
    dataLaporan = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    // print(dataJson);
    return FutureBuilder(
        future: dataLaporan,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: Container(
                  // margin: EdgeInsets.all(10.0),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: ListView(
                        // padding: EdgeInsets.all(5),
                        children: [
                          buildCard(),
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }
}
