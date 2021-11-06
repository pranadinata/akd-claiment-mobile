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
    String urlAllDataSppa = apiRoute.DATA_SPPA_ALL_DATA;
    http.Response result = await http.post(Uri.parse(urlAllDataSppa),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
    Map dataAll = json.decode(result.body); 
    dataJson = dataAll["data"];
    _isExpanded = new List<bool>.generate(dataJson.length, (i) => false);
    return dataJson;
  }
 
  buildCard() {
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
                    title: Text(dataJson[index]['peserta_1']),
                    subtitle: Text(dataJson[index]['peserta_2']),
                  ),
                ButtonTheme(
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Perjanjian.pdf",
                        style: TextStyle(
                          // color: ThemeColors.primaryDark,
                          fontWeight: FontWeight.normal,
                          // fontSize: ThemeSizes.normalFont,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    onPressed: () => (){},
                  ),
                )
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
