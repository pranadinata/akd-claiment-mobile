import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fragment_navigate/navigate-control.dart';

//class tambahan
import 'package:akd_flutter/main.dart';
import 'package:akd_flutter/views/admin/data_claiment/data_claiment_page.dart';
import 'package:akd_flutter/views/admin/data_claiment/form_data_claiment.dart';
import 'package:akd_flutter/views/admin/dashboard/dashboard_user_page.dart';

final String dashboardUser = 'Dashboard User';
final String dataKlaiment = 'Data Klaiment';
final String dataSPPA = 'SPPA';
final String dataPenjualan = 'Penjualan';
final String dataAbout = 'About';
// final String signOut = 'Sign Out';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Main(),
      ),
      routes: <String, WidgetBuilder>{
        '/logout': (BuildContext context) => new MyApp(),
      },
    );
  }
}

class Main extends StatelessWidget {
  static final FragNavigate _fragNav = FragNavigate(
      firstKey: dashboardUser,
      drawerContext: null,
      screens: <Posit>[
        Posit(
          key: dashboardUser,
          title: dashboardUser,
          icon: Icons.person_pin,
          fragment: DashboardUser(),
        ),
        Posit(
          key: dataKlaiment,
          title: dataKlaiment,
          icon: Icons.person_pin,
          fragment: dataClaiment(),
        ),
        Posit(
          key: dataSPPA,
          title: dataSPPA,
          icon: Icons.my_library_books_outlined,
          fragment: Text(dataSPPA),
        ),
        Posit(
          key: dataPenjualan,
          title: dataPenjualan,
          icon: Icons.mobile_friendly_rounded,
          fragment: Text(dataPenjualan),
        ),
        Posit(
          key: dataAbout,
          title: dataAbout,
          icon: Icons.outbox_rounded,
          fragment: Text(dataAbout),
        ),
        // Posit(
        //     key: signOut,
        //     title: signOut,
        //     icon: Icons.logout,
        //     fragment: Text(dataAbout)),
      ],
      actionsList: [
        ActionPosit(
          keys: [
            dashboardUser,
            dataKlaiment,
            dataSPPA,
            dataPenjualan,
            dataAbout
          ],
          actions: <Widget>[],
        )
      ],
      bottomList: [
        // BottomPosit(
        //     keys: [home, b, c],
        //     length: 2,
        //     child: TabBar(
        //       indicatorColor: Colors.white,
        //       tabs: <Widget>[Text('a'), Text('b')],
        //     ))
      ]);

  @override
  Widget build(BuildContext context) {
    _fragNav.setDrawerContext = context;

    return StreamBuilder<FullPosit>(
        stream: _fragNav.outStreamFragment,
        builder: (con, s) {
          if (s.data != null)
            return DefaultTabController(
              length: s.data!.bottom?.length ?? 1,
              child: Scaffold(
                  key: _fragNav.drawerKey,
                  appBar: AppBar(
                    title: Text(s.data!.title ?? 'NULL'),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            button_add(context);
                          })
                    ],
                    bottom: s.data?.bottom?.child,
                    backgroundColor: Colors.blue[300],
                  ),
                  drawer: CustomDrawer(fragNav: _fragNav),
                  body: ScreenNavigate(
                      child: s.data!.fragment, control: _fragNav)),
            );

          return Container();
        });
  }

  static button_add(context) {
    switch (_fragNav.currentKey) {
      case 'Data Klaiment':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => formDataClaiment()),
        );
        break;
      case 'SPPA':
        print('Masuk ke SPPA gan');
        break;
      case 'Penjualan':
        print('Masuk ke Penjualan gan');
        break;
    }
  }
}

class CustomDrawer extends StatelessWidget {
  final FragNavigate fragNav;
  const CustomDrawer({required this.fragNav});

  Widget _getItem(
      {required String currentSelect,
      required text,
      required key,
      required icon}) {
    Color _getColor() => currentSelect == key ? Colors.white : Colors.black87;

    return Material(
        color: currentSelect == key ? Colors.blue[300] : Colors.transparent,
        child: ListTile(
            leading:
                Icon(icon, color: currentSelect == key ? Colors.white : null),
            selected: currentSelect == key,
            title: Text(text, style: TextStyle(color: _getColor())),
            onTap: () => fragNav.putPosit(key: key)));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              color: Colors.blueGrey,
              child: Text('Ini Header'),
            ),
          ),
          for (Posit item in fragNav.screenList.values)
            _getItem(
                currentSelect: fragNav.currentKey,
                text: item.drawerTitle ?? item.title,
                key: item.key,
                icon: item.icon),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sign Out"),
            onTap: () {
              print('keluar app');
              // PreferencesUser().removePref(0);
              // Navigator.pushReplacementNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}
