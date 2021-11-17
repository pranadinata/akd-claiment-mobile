import 'package:akd_flutter/models/config.dart';
import 'package:flutter/material.dart';

class penjualanSPPA extends StatefulWidget {
  const penjualanSPPA({Key? key}) : super(key: key);

  @override
  _penjualanSPPAState createState() => _penjualanSPPAState();
}

class _penjualanSPPAState extends State<penjualanSPPA> {
  Color? color_input = Colors.black;
  late DateTime _selectedDate;
  TextEditingController dateCtl1 = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();
  late String data_pencarian = "";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: setting.background_method(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal Pertama',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color_input),
                  ),
                ),
                TextFormField(
                  controller: dateCtl1,
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
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)));

                    dateCtl1.text = date.toString();
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tanggal kedua',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: "Aller", fontSize: 17, color: color_input),
                  ),
                ),
                TextFormField(
                  controller: dateCtl2,
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
                  onTap: () async {
                    DateTime? date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)));

                    dateCtl2.text = date.toString();
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: width,
              child: ElevatedButton(
                onPressed: () {
                  // login(inp_username.text, inp_password.text);
                  // cek_api();
                  setState(() {
                    data_pencarian = dateCtl1.text + ' S/D ' + dateCtl2.text;
                  });
                },
                child: Text(
                  'Cari Tanggal',
                  style: new TextStyle(
                    fontSize: 20.0,
                    // color: Colors.yellow,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[300],
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // <-- Radius
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Text(data_pencarian),
            )
          ],
        ),
      ),
    );
  }
}
