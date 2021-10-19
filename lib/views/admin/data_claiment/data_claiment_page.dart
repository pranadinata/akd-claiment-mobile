import 'package:flutter/material.dart';

class dataClaiment extends StatefulWidget {
  const dataClaiment({Key? key}) : super(key: key);

  @override
  _dataClaimentState createState() => _dataClaimentState();
}

class _dataClaimentState extends State<dataClaiment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // color: Colors.green,
      child: ListView(
        children: <Widget>[
          buildCard(),
        ],
      ),
    );
  }

  Card buildCard() {
    return Card(
      elevation: 10,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Icon(Icons.account_box),
          ),
          Text("coba"),
        ],
      ),
    );
  }
}
