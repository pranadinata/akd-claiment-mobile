import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:akd_flutter/views/admin/main_page.dart';
import 'package:akd_flutter/views/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ini Admin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String app_name = "Akd Claiment";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      home: (_loginStatus == 1) ? MainPage() : LoginPage(),
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new LoginPage(),
        // '/signup': (BuildContext context) => new RegisterPage(),
        '/home': (BuildContext context) => new MainPage(),
      },
    );
  }

  var _loginStatus = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = 1;
      // _loginStatus = preferences.getInt("value")!;
    });
  }
}
