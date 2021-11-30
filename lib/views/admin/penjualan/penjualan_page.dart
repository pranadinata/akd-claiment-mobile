import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flowder/flowder.dart';
import 'package:open_file/open_file.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

//package tambahan
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
class penjualanSPPA extends StatefulWidget {
  const penjualanSPPA({Key? key}) : super(key: key);

  @override
  _penjualanSPPAState createState() => _penjualanSPPAState();
}

class _penjualanSPPAState extends State<penjualanSPPA> {
  List dataJson = [];
  late DownloaderUtils options;
  late DownloaderCore core;

  TextEditingController dateCtl1 = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      // decoration: setting.background_method(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal Pertama',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color.MInputName),
                  ),
                ),
                TextFormField(
                  controller: dateCtl1,
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
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)));

                    dateCtl1.text = date.toString().split(' ')[0];
                    // print(date.toString());
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal kedua',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color.MInputName),
                  ),
                ),
                TextFormField(
                  controller: dateCtl2,
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
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    
                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)));

                    dateCtl2.text = date.toString().split(' ')[0];
                    // Text("${selectedDate.toLocal()}".split(' ')[0]),
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  print(dataJson);
                  cek_tanggal(dateCtl1.text, dateCtl2.text, context);
                },
                child: Text(
                  'Cari Tanggal',
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
            Container(
              margin: EdgeInsets.all(10),
              // child: buildCard(context),
            ),
            Container(
              // margin: EdgeInsets.all(10),
              child: buildCard(context),
            ),
          ],
        ),
      ),
    );
  }
  cek_tanggal(date_awal, date_akhir, context) async {
    
    PreferencesUser preferencesUser1 = await PreferencesUser();
    var user_id = await preferencesUser1.getUser("id");
    Map data = {'date_awal': date_awal, 'date_akhir': date_akhir, 'id_user': user_id };
    print(data);
    final response = await http.post(Uri.parse(apiRoute.DATA_SPPA_SHOW_PENJUALAN),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
      
      if(response.statusCode == 200){
        Map<String, dynamic> resposneAll = jsonDecode(response.body);
        Map dataAll = jsonDecode(response.body);
        
        setState(() {
            print('ada');
            dataJson = dataAll['data'];
          });
      }else{
        setState(() {
            print('Tidak ada');
            dataJson = [];
            // dataJson = dataAll['data'];
          });
      }
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
                            child: Text(dataJson[index]['nama_lengkap'].toString()),
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
                    title: Text(dataJson[index]['nama_lengkap'].toString()),
                    subtitle: Text(dataJson[index]['jumlah_premi'].toString()),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: (){
                        print(dataJson[index]['file_document_sppa']); 
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
}


