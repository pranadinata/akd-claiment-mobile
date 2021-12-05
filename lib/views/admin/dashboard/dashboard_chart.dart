
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:pie_chart/pie_chart.dart';

//package tambahan
import 'package:akd_flutter/models/api_route.dart' as apiRoute;
import 'package:akd_flutter/models/preferences.dart';

class DashboardChart extends StatefulWidget {
  const DashboardChart({ Key? key }) : super(key: key);

  @override
  _DashboardChartState createState() => _DashboardChartState();
}

enum LegendShape { Circle, Rectangle }

class _DashboardChartState extends State<DashboardChart> {
List dataJson_jenis_kelamin = [
  0,0
];

late Future<List> dataLaporan_jenis_kelamin;

//list data json dari Api
Future<List> fetchData_jenis_kelamin() async {
    PreferencesUser preferencesUser1 = await PreferencesUser();
    var user_id = await preferencesUser1.getUser("id");
    String urlAllDataJenis_kelamin = apiRoute.DATA_SPPA_SHOW_CHART_JENIS_KELAMIN;
    http.Response result = await http.post(Uri.parse(urlAllDataJenis_kelamin),
        headers: {"Accept": "application/json"}, body: {'id_user': user_id});
        
    Map dataAll = json.decode(result.body); 
    dataJson_jenis_kelamin = [
      dataAll['data']['perempuan'],
      dataAll['data']['laki_laki']
    ];
    return dataJson_jenis_kelamin;
  }

  final colorList = <Color>[
    Color(0xfffdcb6e),
    Color(0xff0984e3),
    Color(0xfffd79a8),
    Color(0xffe17055),
    Color(0xff6c5ce7),
  ];
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;
  int key = 0;
  
@override
  void initState() {
    dataLaporan_jenis_kelamin = fetchData_jenis_kelamin();
  }
  @override
  Widget build(BuildContext context) {
    chart_jenis_kelamin(perempuan, laki_laki){
      return PieChart(
          // key: ValueKey(key),
          dataMap: {
            "Perempuan": perempuan.toDouble(),
            "Laki - Laki": laki_laki.toDouble(),
            // "Xamarin": 2,
            // "Ionic": 2,
            },
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: _chartLegendSpacing!,
          chartRadius: MediaQuery.of(context).size.width / 3 > 300
              ? 300
              : MediaQuery.of(context).size.width / 2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: _chartType!,
          // centerText: _showCenterText ? "HYBRID" : null,
          legendOptions: LegendOptions(
            showLegendsInRow: _showLegendsInRow,
            legendPosition: _legendPosition!,
            showLegends: _showLegends,
            legendShape: _legendShape == LegendShape.Circle
                ? BoxShape.circle
                : BoxShape.rectangle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: _showChartValueBackground,
            showChartValues: _showChartValues,
            showChartValuesInPercentage: _showChartValuesInPercentage,
            showChartValuesOutside: _showChartValuesOutside,
          ),
          ringStrokeWidth: _ringStrokeWidth!,
          emptyColor: Colors.grey,
          gradientList: _showGradientColors ? gradientList : null,
          emptyColorGradient: [
            Color(0xff6c5ce7),
            Colors.blue,
          ],
        );
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: chart_jenis_kelamin(dataJson_jenis_kelamin[0],dataJson_jenis_kelamin[1]),
                ),
               
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                      future: dataLaporan_jenis_kelamin,
                      builder:  (context, AsyncSnapshot snapshot) {
                        return Container(
                          child: (dataJson_jenis_kelamin[0] == 0 && dataJson_jenis_kelamin[1] == 0) ? 
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Text('Tidak ada data') ,
                              ) : 
                            chart_jenis_kelamin(dataJson_jenis_kelamin[0],dataJson_jenis_kelamin[1]),
                          margin: EdgeInsets.symmetric(
                              vertical: 32,
                            ),
                        ); 
                    }),
                    FutureBuilder(
                      future: dataLaporan_jenis_kelamin,
                      builder:  (context, AsyncSnapshot snapshot) {
                        return Container(
                          child: (dataJson_jenis_kelamin[0] == 0 && dataJson_jenis_kelamin[1] == 0) ? 
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Text('Tidak ada data') ,
                              ) : 
                            chart_jenis_kelamin(dataJson_jenis_kelamin[0],dataJson_jenis_kelamin[1]),
                          margin: EdgeInsets.symmetric(
                              vertical: 32,
                            ),
                        ); 
                    }),
                    FutureBuilder(
                      future: dataLaporan_jenis_kelamin,
                      builder:  (context, AsyncSnapshot snapshot) {
                        return Container(
                          child: (dataJson_jenis_kelamin[0] == 0 && dataJson_jenis_kelamin[1] == 0) ? 
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Text('Tidak ada data') ,
                              ) : 
                            chart_jenis_kelamin(dataJson_jenis_kelamin[0],dataJson_jenis_kelamin[1]),
                          margin: EdgeInsets.symmetric(
                              vertical: 32,
                            ),
                        ); 
                    }),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}