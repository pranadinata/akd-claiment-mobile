import 'package:flutter/material.dart';

class dataClaiment extends StatefulWidget {
  @override
  _dataClaimentState createState() => _dataClaimentState();
}

class _dataClaimentState extends State<dataClaiment> {
  //inisialisasi list ke dalam array
  List<Widget> data_claiment = [];

  //constractor
  _dataClaimentState() {
    for (var i = 0; i < 10; i++) {
      // data_claiment.add(Text("Text - " + i.toString()));
      data_claiment.add(buildCard());
    }
  }

  //method card
  Card buildCard() {
    return Card(
      elevation: 10,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Icon(Icons.account_box),
          ),
          Text("coba"),
          Text("Masa sih"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // color: Colors.green,
      child: ListView(
        children: data_claiment,
      ),
    );
  }
}
