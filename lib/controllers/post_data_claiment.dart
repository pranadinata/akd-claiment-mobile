import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

//package tambahan
import 'package:akd_flutter/models/api_route.dart';
import 'package:akd_flutter/views/admin/data_claiment/data_claiment_page.dart';

class PostDataClaiment {
  String? nama_lengkap, alamat,no_tlp, id_user;
  PostDataClaiment({
    required this.nama_lengkap,
    required this.alamat,
    required this.no_tlp,
    required this.id_user,
  });

  factory PostDataClaiment.createPostDataClaiment(Map<String, dynamic> object) {
    return PostDataClaiment(
      nama_lengkap: object['nama_lengkap'],
      alamat: object['alamat'],
      no_tlp: object['no_tlp'],
      id_user: object['id_user'],
    );
  }

  static Future<PostDataClaiment> connectToAPI(
      String nama_lengkap, String alamat, String no_tlp, String id_user) async {
    var apiResult = await http.post(
      Uri.parse(DATA_CLAIMENT_STORE),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "nama_lengkap": nama_lengkap,
        "alamat": alamat,
        "no_tlp": no_tlp,
        "id_user": id_user,
      },
    );
    // print(apiResult.body);
    var jsonObject = json.decode(apiResult.body);
    DataClaiment().myAppState.initState();
    return PostDataClaiment.createPostDataClaiment(jsonObject);
  }
}

class updatePostDataKlaiment{
  String? nama_lengkap, alamat,no_tlp, id_dataClaiment;
  updatePostDataKlaiment({
    required this.nama_lengkap,
    required this.alamat,
    required this.no_tlp,
    required this.id_dataClaiment,
  });

   factory updatePostDataKlaiment.updatePostDataClaiment(Map<String, dynamic> object) {
    return updatePostDataKlaiment(
      nama_lengkap: object['nama_lengkap'],
      alamat: object['alamat'],
      no_tlp: object['no_tlp'],
      id_dataClaiment: object['id_dataClaiment'],
    );
  } 
  static Future<updatePostDataKlaiment> connectToAPI(
      String nama_lengkap, String alamat, String no_tlp, String id_dataClaiment) async {
    var apiResult = await http.post(
      Uri.parse(DATA_CLAIMENT_UPDATE),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "nama_lengkap": nama_lengkap,
        "alamat": alamat,
        "no_tlp": no_tlp,
        "id_dataClaiment": id_dataClaiment,
      },
    );
    // print(apiResult.body);
    var jsonObject = json.decode(apiResult.body);
    DataClaiment().myAppState.initState();
    return updatePostDataKlaiment.updatePostDataClaiment(jsonObject);
  }
}

class deletePostDataKlaiment{

}

