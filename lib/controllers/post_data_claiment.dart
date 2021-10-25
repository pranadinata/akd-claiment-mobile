import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:akd_flutter/models/api_route.dart';

class PostDataClaiment {
  String? nama_lengkap, alamat;
  PostDataClaiment({
    required this.nama_lengkap,
    required this.alamat,
  });

  factory PostDataClaiment.createPostDataClaiment(Map<String, dynamic> object) {
    return PostDataClaiment(
      nama_lengkap: object['nama_lengkap'],
      alamat: object['alamat'],
    );
  }

  static Future<PostDataClaiment> connectToAPI(
      String nama_lengkap, String alamat) async {
    var apiResult = await http.post(
      Uri.parse(DATA_CLAIMENT_STORE),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "nama_lengkap": nama_lengkap,
        "alamat": alamat,
      },
    );
    print(apiResult.body);
    var jsonObject = json.decode(apiResult.body);
    return PostDataClaiment.createPostDataClaiment(jsonObject);
  }
}
