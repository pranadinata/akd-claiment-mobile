
import 'dart:convert';
// import 'dart:io';
import 'package:akd_flutter/controllers/post_data_sppa.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/views/admin/data_sppa/signature_page.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:akd_flutter/models/api_route.dart' as apiRoute;

class formDataSppa extends StatefulWidget {
  const formDataSppa({Key? key}) : super(key: key);

  @override
  _formDataSppaState createState() => _formDataSppaState();
}

class _formDataSppaState extends State<formDataSppa> {
  var uuid = Uuid();
  Color? color_input = Colors.black;
  Color? apps_appbar = Colors.blue[300];
  String uuid_fileName = '';
  String uploadFileName = "No File Uploaded";
  String uploadFilePath = "";
  String uuid_fileName_ttd = '';
  String uploadFileName_ttd = "No File Uploaded";
  String uploadFilePath_ttd = "";
  String jumlah_premi = "Rp. 0";
  String id_data_klaiment = '';
  TextEditingController alamat = TextEditingController();
  TextEditingController peserta1 = TextEditingController();
  TextEditingController peserta2 = TextEditingController();

  List namaDataKlaimentList= [];

  // String _valGender;
  var _valFriends;
  
 Future<List> getDataKlaiment() async {
   PreferencesUser preferencesUser1 = await PreferencesUser();
    var user_id = await preferencesUser1.getUser("id");
     String urlAllDataClaiment = apiRoute.DATA_CLAIMENT_ALL_DATA;
   http.Response result = await http.post(Uri.parse(urlAllDataClaiment),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});

    this.setState(() {
      Map<String, dynamic> namaDataKlaimentListAll = json.decode(result.body);
      namaDataKlaimentList = namaDataKlaimentListAll['data'];
    });
    return namaDataKlaimentList;
    
  }
  Future uploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        var file_ktp = uuid.v1();
        uuid_fileName = file_ktp;
        uploadFileName = file.name;
        uploadFilePath = file.path!;
      });
    } else {
      // User canceled the picker
    }
    setState(() {
      // _isButtonDisabled = true;
    });
  }
   Future tandaTangan() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result);
    if (result != null) {
      PlatformFile file_ttd = result.files.first;
      setState(() {
        var file_ttd_name = uuid.v1();
        uuid_fileName_ttd = file_ttd_name;
        uploadFileName_ttd = file_ttd.name;
        uploadFilePath_ttd = file_ttd.path!;
      });
    } else {
      // User canceled the picker
    }

  }

  void _postFileKTP() async {
    FormData formData = new FormData.fromMap({
      "foto_ktp_peserta": await MultipartFile.fromFile(uploadFilePath,
          filename: uploadFileName,),
    });
    // print(formData);
    Response response = await Dio().post(apiRoute.DATA_SPPA_STORE_FILE, data: formData);
    print("File uploaded response : $response");
  }
  void _postFileTTD() async {
    FormData formData = new FormData.fromMap({
      "foto_tanda_tangan": await MultipartFile.fromFile(uploadFilePath_ttd,
          filename: uploadFileName_ttd,),
    });

    Response response = await Dio().post(apiRoute.DATA_SPPA_STORE_FILETTD, data: formData);
    print("File uploaded response : $response");
  }
   void _clearForm() {
    setState(() {
        alamat.clear();
        peserta1.clear();
        peserta2.clear();
        uuid_fileName = '';
        uploadFileName = "No File Uploaded";
        uploadFilePath = "";
        uuid_fileName_ttd = '';
        uploadFileName_ttd = "No File Uploaded";
        uploadFilePath_ttd = "";
        jumlah_premi = "Rp. 0";
        id_data_klaiment = '';
    });
  }
 @override
  void initState() {
    // TODO: implement initState
   getDataKlaiment();
  }
  @override
  Widget build(BuildContext context) {
    // print(_valFriends);
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
                    PostDataSPPA.connectToAPI(id_data_klaiment,peserta1.text.toString(),peserta2.text.toString(),uploadFileName,uploadFileName_ttd, uuid_fileName, uuid_fileName_ttd);
                    _postFileTTD();
                    _postFileKTP();
                    // print(id_data_klaiment);                 
                    
                    final snackBar = SnackBar(content: Text('Berhasil Masuk'));
                    // Navigator.push(DataClaiment).then((value) => setState(() {}));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    _clearForm();
                    Navigator.pop(context, () {
                      setState(() {});
                    });
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
                  hint: Text("Pilih Nama Data Claiment"),
                  value: _valFriends,
                  items: namaDataKlaimentList.map((value) {
                    return DropdownMenuItem(
                      child: Text(value['nama_lengkap']),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valFriends = value as dynamic;
                      id_data_klaiment = _valFriends['id'].toString();
                      alamat.text = _valFriends['alamat'];
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
                    enabled: false, 
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
                        // _valFriends = value as String?;
                        // alamat.text = _valFriends;
                      });
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
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Peserta 2',
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
                      setState(() {
                      });
                    },
                    controller: peserta2,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Jumlah Premi',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Aller",
                          fontSize: 17,
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    children: <Widget>[       
                      Flexible(child: 
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          // height: 80,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                    String text_peserta1, text_peserta2;
                                    text_peserta1 = peserta1.text;
                                    text_peserta2 = peserta2.text;
                                    if(text_peserta1 != '' && text_peserta2 != ''){
                                        jumlah_premi = "Rp. 250.000";
                                    }else{
                                      if(text_peserta1 != '' || text_peserta2 != ''){
                                          jumlah_premi = "Rp. 125.000";
                                      }else{
                                        jumlah_premi = "Rp. 0";
                                      }
                                    }
                                });
                                
                              },
                              child: Text('Hitung Premi',
                              style: new TextStyle(
                                    fontSize: 20.0,
                                    // color: Colors.yellow,
                                  ),
                              ),  
                            ),
                          )
                        ),
                        Flexible(
                        child: Text(jumlah_premi , 
                        style: new TextStyle(
                                    fontSize: 20.0,
                                    // color: Colors.yellow,
                                  ),
                        )
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Foto KTP Peserta',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "Aller",
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text("Upload File"),
                              ),
                            ),
                            RaisedButton(
                                onPressed: uploadFile,
                                child: Text("Browse")),
                            
                            // Container(
                            //     margin: EdgeInsets.only(left: 5.0, right: 5.0),
                            //     child: Text("atau")),
                            // RaisedButton(
                            //     onPressed: (){},
                            //     child: Icon(Icons.camera_alt)),
                          ],
                        ),
                      ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10.0,top: 10.0),
                          child: Text(uploadFileName)),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                  ),
                  Column(
                    // mainAxisAlignment: EdgeInsets.all(value),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tanda Tangan',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "Aller",
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text("Upload File"),
                              ),
                            ),
                            RaisedButton(
                                onPressed: tandaTangan,
                                child: Text("Browse")),
                            
                            Container(
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Text("atau")),
                            RaisedButton(
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignaturePage()),
                                    );
                                },
                                child: Icon(Icons.pattern_sharp)),
                          ],
                        ),
                      ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 10.0,top: 10.0),
                          child: Text(uploadFileName_ttd)
                          ),
                    ],
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
