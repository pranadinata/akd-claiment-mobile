import 'package:flutter/material.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/models/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

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
    String urlAllDataSppa = apiRoute.DATA_SPPA_ALL_DATA;
    http.Response result = await http.post(Uri.parse(urlAllDataSppa),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
    Map dataAll = json.decode(result.body); 
    dataJson = dataAll["data"];
    _isExpanded = new List<bool>.generate(dataJson.length, (i) => false);
    return dataJson;
  }
  buildCard(context) {
    if(dataJson.isEmpty){
      return Text('Tidak ada data');
    }else{
      return Column(
        children: <Widget>[
          Column(
              children: List.generate(dataJson.length, (index) => Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: (){
                      showDialog(context: context, builder: (context){ 
                        return AlertDialog(
                          title: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(dataJson[index]['nama_lengkap']),
                          ),
                          content: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Text('Peserta 1 : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['peserta_1']),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Text('Peserta 2 : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['peserta_2']),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Text('Jumlah Premi : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Rp. '+dataJson[index]['jumlah_premi'].toString()),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Text('Pembuatan : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['created_at']),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                    },
                    title: Text(dataJson[index]['nama_lengkap']),
                    subtitle: Text(dataJson[index]['jumlah_premi'].toString()),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('COBA.pdf'),
                      onPressed: () {
                        print(dataJson[index]);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                ],
              ),
                elevation: 8,
                shadowColor: Colors.blue,
                // margin: EdgeInsets.all(5),
              ),
            ), 
          ),
        ]
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
                          buildCard(context),
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }
}
