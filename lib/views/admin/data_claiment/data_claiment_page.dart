import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/views/admin/data_claiment/updateForm_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

class DataClaiment extends StatefulWidget {
  // get onGoBack => null;
  final _DataClaimentState myAppState = new _DataClaimentState();
  @override
  _DataClaimentState createState() => _DataClaimentState();
  onGoBack() {
    // myAppState.dataLaporan = myAppState.fetchData();
    myAppState.initState();
  }
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
      return Column(
        children: List.generate(
            dataJson.length,
            (index) => Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          //  print(dataJson);
                          showDialog(
                            context: context,
                            builder: (context) {
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
                                            Text(
                                              'Alamat : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(dataJson[index]['alamat'])
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              'No Telepon : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(dataJson[index]['no_tlp']),
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
                            },
                          );
                        },
                        title: Text(dataJson[index]['nama_lengkap']),
                        subtitle: Text(dataJson[index]['alamat']),
                      ),
                      (dataJson[index]['status_sppa']) == 1
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'UPDATE',
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              updateDataClaiment(
                                                id: dataJson[index]['id'],
                                                nama_lengkap_old:
                                                    dataJson[index]
                                                        ['nama_lengkap'],
                                                alamat_old: dataJson[index]
                                                    ['alamat'],
                                                no_tlp_old: dataJson[index]
                                                    ['no_tlp'],
                                              )),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'UPDATE',
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text(
                                    'DELETE',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    print(dataJson[index]['id']);
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                      // print(dataJson[index]['status_sppa']);
                    ],
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
    dataLaporan = fetchData();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
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
