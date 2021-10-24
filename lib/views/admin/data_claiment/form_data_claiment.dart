import 'package:flutter/material.dart';

class formDataClaiment extends StatefulWidget {
  @override
  _formDataClaimentState createState() => _formDataClaimentState();
}

class _formDataClaimentState extends State<formDataClaiment> {
  TextEditingController nama_lengkap = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tambah data'),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Nama Lengkap'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    maxLength: 100,
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: nama_lengkap,
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
