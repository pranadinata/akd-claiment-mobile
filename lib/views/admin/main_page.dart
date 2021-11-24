import 'package:flutter/material.dart';
import 'package:fragment_navigate/navigate-control.dart';

//class tambahan
import 'package:akd_flutter/main.dart';
import 'package:akd_flutter/models/config.dart';
import 'package:akd_flutter/models/preferences.dart';
import 'package:akd_flutter/views/admin/penjualan/penjualan_page.dart';
import 'package:akd_flutter/views/admin/data_sppa/data_sppa_page.dart';
import 'package:akd_flutter/views/admin/data_claiment/data_claiment_page.dart';
import 'package:akd_flutter/views/admin/data_claiment/createForm_page.dart';
import 'package:akd_flutter/views/admin/data_sppa/form_data_sppa.dart';
import 'package:akd_flutter/views/admin/dashboard/dashboard_user_page.dart';

final String dashboardUser = 'Halaman Utama';
final String dataKlaiment = 'Data Klaiment';
final String dataSPPA = 'Data SPPA';
final String dataPenjualan = 'Penjualan';
final String dataAbout = 'About';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: 
        Main(),
      ),
      routes: <String, WidgetBuilder>{
        '/logout': (BuildContext context) => new MyHomePage(title: 'ini Admin'),
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
          icon: Icons.dashboard_sharp,
          fragment: DashboardUser(),
        ),
        Posit(
          key: dataKlaiment,
          title: dataKlaiment,
          icon: Icons.person_pin,
          fragment: DataClaiment(),
        ),
        Posit(
          key: dataSPPA,
          title: dataSPPA,
          icon: Icons.my_library_books_outlined,
          fragment: DataSPPA(),
        ),
        Posit(
          key: dataPenjualan,
          title: dataPenjualan,
          icon: Icons.mobile_friendly_rounded,
          fragment: penjualanSPPA(),
        ),
        // Posit(
        //   key: dataAbout,
        //   title: dataAbout,
        //   icon: Icons.outbox_rounded,
        //   fragment: Text(dataAbout),
        // ),
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
            // dataAbout
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
    // print(_fragNav.currentKey);
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
                    // actions: button_add(context),
                    bottom: s.data?.bottom?.child,
                    backgroundColor: color.MBase,
                  ),
                  floatingActionButton: (_fragNav.currentKey) == 'Data Klaiment'
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => formDataClaiment()),
                            );
                          },
                          child: const Icon(Icons.add),
                          backgroundColor: color.MBase,
                        )
                      : (_fragNav.currentKey) == 'Data SPPA'
                          ? FloatingActionButton(
                              onPressed: () {
                                // Add your onPressed code here!
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => formDataSppa()),
                                );
                              },
                              child: const Icon(Icons.add),
                              backgroundColor: color.MBase,
                            )
                          : Container(),
                  drawer: CustomDrawer(fragNav: _fragNav),
                  body: ScreenNavigate(
                        child: s.data!.fragment, control: _fragNav),
                  ),
            );

          return Container(
          );
        });
  }
}

class CustomDrawer extends StatelessWidget {
  final FragNavigate fragNav;
  String user = "";
  CustomDrawer({required this.fragNav});

  Widget _getItem(
      {required String currentSelect,
      required text,
      required key,
      required icon}) {
    Color _getColor() => currentSelect == key ? Colors.white : Colors.black87;

    return Material(
        color: currentSelect == key ? color.MBase : Colors.transparent,
        child: ListTile(
            leading:
                Icon(icon, color: currentSelect == key ? Colors.white : null),
            selected: currentSelect == key,
            title: Text(text, style: TextStyle(color: _getColor())),
            onTap: () => fragNav.putPosit(key: key)));
  }

  Future<String> getUser() async {
    PreferencesUser preferencesUser1 = await PreferencesUser();
    user = await preferencesUser1.getUser("name");
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 5,
                    child: Align(
                      child: Image(
                        image: AssetImage("assets/images/logo_jp-aspri.png"),
                        fit: BoxFit.cover,
                      ),
                    )),
              ],
            )),
            for (Posit item in fragNav.screenList.values)
              _getItem(
                  currentSelect: fragNav.currentKey,
                  text: item.drawerTitle ?? item.title,
                  key: item.key,
                  icon: item.icon),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Keluar"),
              onTap: () {
                PreferencesUser().removePref(0);
                Navigator.pushReplacementNamed(context, '/logout');
              },
            ),
          ],
        ),
      );
    });
  }
}
