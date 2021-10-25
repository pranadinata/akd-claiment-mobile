import 'package:flutter/material.dart';

class formDataSppa extends StatefulWidget {
  const formDataSppa({Key? key}) : super(key: key);

  @override
  _formDataSppaState createState() => _formDataSppaState();
}

class _formDataSppaState extends State<formDataSppa> {
  TextEditingController alamat = TextEditingController();
  // String _valGender;
  String? _valFriends;
  List _myFriends = [
    "Clara",
    "John",
    "Rizal",
    "Steve",
    "Laurel",
    "Bernard",
    "Miechel"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SPPA'),
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
                  hint: Text("Select Your Friends"),
                  value: _valFriends,
                  items: _myFriends.map((value) {
                    return DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valFriends = value as String?;
                      // print(_valFriends);
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
                    controller: alamat,
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
