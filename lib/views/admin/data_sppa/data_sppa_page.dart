import 'package:flutter/material.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/models/preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
class DataSPPA extends StatefulWidget {
  const DataSPPA({Key? key}) : super(key: key);

  @override
  _DataSPPAState createState() => _DataSPPAState();
}

class _DataSPPAState extends State<DataSPPA> {
  List<Widget> data_sppa = [];
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
  _DataSPPAState() {
    for (var i = 0; i < 2; i++) {
      // data_claiment.add(Text("Text - " + i.toString()));
      data_sppa.add(buildCard());
    }
  }
  @override
  Card buildCard() {
    return Card(
      elevation: 10,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Icon(Icons.account_box),
          ),
          Text("coba"),
          Text("Aja"),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // color: Colors.green,
      child: ListView(
        children: data_sppa,
      ),
    );
  }
}
