import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

//package tambahan
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/views/admin/data_claiment/updateForm_page.dart';

class DataClaiment extends StatefulWidget {
  // get onGoBack => null;
  final _DataClaimentState myAppState = new _DataClaimentState();
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
    // setState(() {
    //   print(dataJson.length);
    // });
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
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: ElevatedButton.icon(
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
                                    icon: Icon(Icons.update_rounded, size: 18),
                                    label: Text("Ubah"),
                                    style: ElevatedButton.styleFrom(
                                      primary: color.MBase,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: ElevatedButton.icon(
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
                                    icon: Icon(Icons.update_rounded, size: 18),
                                    label: Text("Ubah"),
                                    style: ElevatedButton.styleFrom(
                                      primary: color.MBase,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8,right: 8, bottom: 8),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Wrap(
                                                      children: [
                                                        Text(
                                                          'Apakah anda yakin?',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              FlatButton(
                                                child: Text("Yakin"),
                                                onPressed: () {
                                                  // Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Batal"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.delete_rounded, size: 18),
                                    label: Text("Hapus"),
                                    style: ElevatedButton.styleFrom(
                                      primary: color.MRed,
                                    ),
                                  ),
                                ),
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
    // dataJson.clear();
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
            return RefreshIndicator(
              onRefresh: refreshData,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  buildCard()
                ],
                // return buildCard(),
              ),
            );
          }
      }
    );
  }
  Future refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      final snackBar = SnackBar(content: Text('Berhasil di reload'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // print(dataJson.length);
      fetchData();
    });
    
  }
}
