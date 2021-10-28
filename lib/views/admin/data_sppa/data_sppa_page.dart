import 'package:flutter/material.dart';

class DataSPPA extends StatefulWidget {
  const DataSPPA({Key? key}) : super(key: key);

  @override
  _DataSPPAState createState() => _DataSPPAState();
}

class _DataSPPAState extends State<DataSPPA> {
  List<Widget> data_sppa = [];
  _DataSPPAState() {
    for (var i = 0; i < 2; i++) {
      // data_claiment.add(Text("Text - " + i.toString()));
      data_sppa.add(buildCard());
    }
  }
  @override
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
          Text("Aja"),
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
        children: data_sppa,
      ),
    );
  }
}
