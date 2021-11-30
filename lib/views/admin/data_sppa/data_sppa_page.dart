import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flowder/flowder.dart';
import 'package:open_file/open_file.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

//package tambahan
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/views/admin/data_sppa/detail_data_sppa.dart';

class DataSPPA extends StatefulWidget {
  const DataSPPA({Key? key}) : super(key: key);

  @override
  _DataSPPAState createState() => _DataSPPAState();
}

class _DataSPPAState extends State<DataSPPA> {
  List dataJson = [];
  late DownloaderUtils options;
  late DownloaderCore core;
  late Future<List> dataLaporan;

  Future<List> fetchData() async {
    PreferencesUser preferencesUser1 = await PreferencesUser();
    var user_id = await preferencesUser1.getUser("id");
    String urlAllDataSppa = apiRoute.DATA_SPPA_ALL_DATA;
    http.Response result = await http.post(Uri.parse(urlAllDataSppa),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
    Map dataAll = json.decode(result.body); 
    dataJson = dataAll["data"];
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
                                      Text('Jenis Kelamin Peserta 1 : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['jenis_kelamin_peserta_1']),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      Text('Tgl Lahir Peserta 1 : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['tgl_lahir_peserta_1']),
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
                                      Text('Jenis Kelamin Peserta 2 : ', style: TextStyle(fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(dataJson[index]['jenis_kelamin_peserta_2']),
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
                                  child: Text(dataJson[index]['created_at'].toString()),
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
                    ElevatedButton.icon(
                      onPressed: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //         detailDataSppa(id: dataJson[index]['id']),
                        //         // updateDataClaiment(
                        //         //   id: dataJson[index]['id'],
                        //         //   nama_lengkap_old:
                        //         //       dataJson[index]
                        //         //           ['nama_lengkap'],
                        //         //   alamat_old: dataJson[index]
                        //         //       ['alamat'],
                        //         //   no_tlp_old: dataJson[index]
                        //         //       ['no_tlp'],
                        //         // )
                        //         ),
                        // );
                      }, 
                      icon: Icon(Icons.remove_red_eye_rounded), 
                      label: Text('View'),
                      style: ElevatedButton.styleFrom(
                        primary: color.MBase,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.file_present_outlined, size: 18),
                      label: Text("Unduh File"),
                      style: ElevatedButton.styleFrom(
                        primary: color.MRed,
                      ),
                      onPressed: () async {
                        // final baseStorage = '/storage/emulated/0/Android/data/com.akd.akd_flutter/files/';
                        String baseStorage;

                        baseStorage = await ExternalPath.getExternalStoragePublicDirectory(
                            ExternalPath.DIRECTORY_DOWNLOADS);

                        final directory = await getExternalStorageDirectory();
                        // For your reference print the AppDoc directory 
                        print(directory);
                        options = DownloaderUtils(
                            progressCallback: (current, total) {
                              final progress = (current / total) * 100;
                              print('Downloading: $progress');
                            },
                            file: File(baseStorage + dataJson[index]['file_document_sppa']), 
                            progress: ProgressImplementation(),
                            onDone: () {
                                  OpenFile.open(baseStorage + 'AKD Claiment.pdf');
                            },
                            deleteOnCancel: true,
                          );
                        // print(dataJson[index]);
                        core = await Flowder.download((apiRoute.PUBLIC+'pdf_/'+dataJson[index]['file_document_sppa']), options);
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
            return RefreshIndicator(
              onRefresh: refreshData,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  buildCard(context),
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


