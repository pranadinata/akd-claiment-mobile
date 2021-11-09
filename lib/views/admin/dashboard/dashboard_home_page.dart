import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:akd_flutter/models/colors.dart';
import 'package:akd_flutter/main.dart';
import 'package:akd_flutter/views/admin/main_page.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/views/admin/dashboard/top_container.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({ Key? key }) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: dashboardHome(),
      ),
      routes: <String, WidgetBuilder>{
        '/logout': (BuildContext context) => new MyHomePage(title: 'ini Admin'),
        '/homeUser' : (BuildContext context) => new MainPage(),
      },
    );
  }
}

class dashboardHome extends StatelessWidget {
  String user = "";
  String jabatan = "";

  Future<String> getUser() async {
    PreferencesUser preferencesUser1 = await PreferencesUser();
    user = await preferencesUser1.getUser("name");
    // jabatan = await preferencesUser1.getUser("email");
    return user;
    // return jabatan;
    // return user;
  }
  Text subheading(String title) {
      return Text(
        title,
        style: TextStyle(
            color: color.Mblue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2),
      );
    }
    CircleAvatar calendarIcon() {
      return CircleAvatar(
        radius: 25.0,
        backgroundColor: color.Mblue,
        child: Icon(
          Icons.calendar_today,
          size: 20.0,
          color: color.Mblue,
        ),
      );
    }
  // PreferencesUser preferencesUser1 = new PreferencesUser();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
  
    return FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.blueAccent[50],
            body: SafeArea(
            child: Column(
              children: <Widget>[
                TopContainer(
                    height: 200, 
                    width: width, 
                    padding: EdgeInsets.symmetric(),
                    child: Column(
                      
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Icon(Icons.menu,
                        //         color: Colors.redAccent, size: 30.0),
                        //     Icon(Icons.search,
                        //         color: Colors.redAccent, size: 25.0),
                        //   ],
                        // ),
                        Container(
                          margin: EdgeInsets.all(30),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CircularPercentIndicator(
                                radius: 90.0,
                                lineWidth: 5.0,
                                animation: true,
                                percent: 0.75,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.redAccent,
                                backgroundColor: color.Mblue,
                                center: CircleAvatar(
                                  backgroundColor: color.Mblue,
                                  radius: 35.0,
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      // preferencesUser1.getUser('nama_lengkap'),
                                      user,
                                      
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'User',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          )
                      ],
                    ), 
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),Container(
                        //   margin: EdgeInsets.all(20),
                        //   child: Text('Masuk'),
                        // ),
                        
                      ],
                    )
                  ),
                  // Container(
                  //   child: FlatButton( 
                  //       child: Text('Log out'),
                  //       onPressed: (){
                  //         PreferencesUser().removePref(0);
                  //         Navigator.pushReplacementNamed(context, '/logout');
                  //       },
                  //     ),
                  // ),
                  Container(
                    child: FlatButton( 
                        child: Text('Home User'),
                        onPressed: (){
                          // PreferencesUser().removePref(0);
                          Navigator.pushReplacementNamed(context, '/homeUser');
                        },
                      ),
                  ),
                  
              ],
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print('masuk');
          //     // Add your onPressed code here!
          //   },
          //   child: const Icon(Icons.add),
          //   backgroundColor: color.Mblue,
          // ),
          ),
          
          
        );
        });
    
  }
}