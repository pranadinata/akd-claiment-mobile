import 'dart:convert';
import 'package:akd_flutter/main.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:akd_flutter/models/api_route.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String data_json = '';
  bool isLoading = false;
  bool _isObscure = true;
  TextEditingController inp_username = new TextEditingController();
  TextEditingController inp_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Container(
        child: Scaffold(
          // backgroundColor: Colors.blue[200],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),
                    child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 6,
                          child:
                              Image.asset('assets/images/logo_jp-aspri.png')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: inp_username,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Username',
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
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: inp_password,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.vpn_key_sharp),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        hintText: 'Password',
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    width: width,
                    child: ElevatedButton(
                      onPressed: () {
                        login(inp_username.text, inp_password.text);
                        // cek_api();
                      },
                      child: Text(
                        'Masuk',
                        style: new TextStyle(
                          fontSize: 20.0,
                          // color: Colors.yellow,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Text(data_json),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(username, password) async {
    Map data = {'username': username, 'password': password};
    // print(data.toString());
    final response = await http.post(Uri.parse(LOGIN),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (resposne['status_code'] == 200) {
        Map<String, dynamic> user = resposne['data'];
        if (user['group_user'] == 1) {
          PreferencesUser preferencesUser = new PreferencesUser();

          preferencesUser.savePref(1, user['nama_lengkap'].toString(),
              user['username'].toString(), user['id']);
          Fluttertoast.showToast(
              timeInSecForIosWeb: 10,
              webShowClose: true,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              msg: resposne['message']);
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          print('anda admin');
        }
      } else {
        Fluttertoast.showToast(
            timeInSecForIosWeb: 10,
            webShowClose: true,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            msg: resposne['message']);
      }
    } else {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 10,
          webShowClose: true,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          msg: "Incorrect Username");
    }
  }

  cek_api() async {
    final response = await http.get(
      Uri.parse(USER),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },

      // encoding: Encoding.getByName("utf-8")
    );

    var dataAll = json.decode(response.body);
    // print(dataAll);
    setState(() {
      data_json = dataAll.toString();
    });
    return response;
  }
}
