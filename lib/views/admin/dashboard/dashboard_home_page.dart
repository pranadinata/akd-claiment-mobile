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
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Image(
                              image: AssetImage("assets/images/logo_header.jpeg"),
                              // width: 150, 
                              // fit: BoxF,
                              fit: BoxFit.cover,
                        )
                        ),
                        Align(
                          // margin: EdgeInsets.all(20),
                          child: Text('LINDUNGI KELUARGA YANG ANDA CINTAI',style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Text('Kecelakaan, dapat terjadi dimana saja, dan bersifat tiba-tiba. Tidak hanya di jalan raya tapi juga di rumah, di tempat kerja, pusat keramaian atau banyak tempat lainnya. Anda tidak akan pernah menduga apa yang akan terjadi.',textAlign: TextAlign.justify),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
                          child: Text('JP-ASPRI adalah solusi yang tepat untuk memberikan perlindungan bagi Anda, orang-orang yang Anda sayangi, karyawan Anda ataupun rekan-rekan Anda dari risiko kecelakaan, karena JP-ASPRI tidak hanya melindungi di tempat kerja atau di sekolah, tetapi selama 24 jam dimana saja berada. Jangan menunggu waktu percayakan sepenuhnya perlindungan asuransi kecelakaan pribadi pada JP-ASPRI, produk asuransi terpercaya dari JP-INSURANCE.',textAlign: TextAlign.justify),
                        ),
                        Align(
                          // margin: EdgeInsets.all(20),
                          child: Text('KELENGKAPAN BERKAS KLAIM',style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10,),
                          child: Text('1. Tertanggung sesegera mungkin melaporkan/menyampaikan keterangan tertulis mengenai kerugian yang terjadi dengan tidak merubah/merusak objek yang mengalami kerugian.',textAlign: TextAlign.justify),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10,),
                          child: Text('2. Pengajuan klaim dilakukan dengan:',textAlign: TextAlign.justify),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 40, top: 10,),
                          child: Text('(a) Mengisi formulir Laporan Klaim Asuransi Kecelakaan Diri (LK1)'),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 40, top: 10,),
                          child: Text('(b) Melampirkan kwitansi biaya pengobatan'),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 40, top: 10,),
                          child: Text('(c) Melampirkan surat kematian, copy Kartu Keluarga dan KTP khusus untuk meninggal dunia'),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 40, top: 10,),
                          child: Text('(d) Untuk korban cacat tetap dilengkapi dengan laporan kesehatan terakhir dari dokter.'),
                        ),      
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 40, top: 10,),
                          child: Text('(e) Dokumen pendukung lainnya yang diperlukan'),
                        ),
                      ],
                    )
                  ),
                  Container(
                    child: FlatButton(
                        child: Text('Lanjutkan'),
                        minWidth: MediaQuery.of(context).size.width,
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