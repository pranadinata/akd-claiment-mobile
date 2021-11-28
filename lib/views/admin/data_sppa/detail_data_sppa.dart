import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//package tambahan
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;

class detailDataSppa extends StatelessWidget {
  detailDataSppa({required this.id });
  final int id;
  late List dataJson = [];
  // List<Widget> data_sppa = [];
  
  // Future<List> fetchData() async {
  //   // PreferencesUser preferencesUser1 = await PreferencesUser();
  //   // var user_id = await preferencesUser1.getUser("id");
  //   String urlAllDataSppa = apiRoute.DATA_SPPA_ALL_DATA;
  //   http.Response result = await http.post(Uri.parse(urlAllDataSppa),
  //       headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
  //   Map dataAll = json.decode(result.body); 
  //   dataJson = dataAll["data"];
  //   _isExpanded = new List<bool>.generate(dataJson.length, (i) => false);
  //   return dataJson;
  // }
  Future<List> fetchData() async{
        String urlAllDataSppa = apiRoute.DATA_SPPA_SHOW;
        
        http.Response result = await http.post(Uri.parse(urlAllDataSppa),
        headers: {"Accept": "application/json"}, body: {'id_sppa': 7});
        
        Map dataAll = json.decode(result.body); 
        dataJson = dataAll["data"];
    return dataJson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color.MBase,
          title: Text('Detail SPPA'),
        ),
        body: TextButton(onPressed: (){
          print(dataJson);
          // fetchData();
        }, child: Text('ini')),
    );
  }
}