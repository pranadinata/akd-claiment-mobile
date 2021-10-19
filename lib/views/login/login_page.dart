import 'dart:convert';
import 'package:akd_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:akd_flutter/models/api_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
    );
  }
}
