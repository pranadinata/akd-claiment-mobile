import 'package:akd_flutter/views/admin/dashboard/dashboard_home_page.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:akd_flutter/views/admin/main_page.dart';
import 'package:akd_flutter/views/login/login_page.dart';

void main() {
  runApp(MyHomePage(title: 'Ini Admin'));
}
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String app_name = "Akd Claiment";

  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      home: (_loginStatus == 1) ? HomeDashboard() : LoginPage(),
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomeDashboard(),
      },
    );
  }

  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = preferences.getInt("value")!;
      // print(_loginStatus);
    }); 
  }
}

