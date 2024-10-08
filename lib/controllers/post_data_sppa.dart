import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:akd_flutter/models/api_route.dart';

class PostDataSPPA {
  String? id_data_klaiment, peserta_1, jenis_kelamin_peserta_1, tgl_lahir_peserta_1,peserta_2, jenis_kelamin_peserta_2, tgl_lahir_peserta_2, foto_ktp_peserta, foto_tanda_tangan, uuid_fileName, uuid_fileName_ttd, file_document_sppa;
      PostDataSPPA({
        required this.id_data_klaiment,
        required this.peserta_1,
        required this.jenis_kelamin_peserta_1,
        required this.tgl_lahir_peserta_1,
        required this.peserta_2,
        required this.jenis_kelamin_peserta_2,
        required this.tgl_lahir_peserta_2,
        required this.foto_ktp_peserta,
        required this.foto_tanda_tangan,
        required this.uuid_fileName,
        required this.uuid_fileName_ttd,
        required this.file_document_sppa,

      });
factory PostDataSPPA.createPostDataSPPA(Map<String, dynamic> object) {
    return PostDataSPPA(
      id_data_klaiment: object['id_data_klaiment'],
      peserta_1: object['peserta_1'],
      jenis_kelamin_peserta_1: object['jenis_kelamin_peserta_1'],
      tgl_lahir_peserta_1: object['tgl_lahir_peserta_1'],
      peserta_2: object['peserta_2'],
      jenis_kelamin_peserta_2: object['jenis_kelamin_peserta_2'],
      tgl_lahir_peserta_2: object['tgl_lahir_peserta_2'],
      foto_ktp_peserta: object['foto_ktp_peserta'],
      foto_tanda_tangan: object['foto_tanda_tangan'],
      uuid_fileName: object['uuid_fileName'],
      uuid_fileName_ttd: object['uuid_fileName_ttd'],
      file_document_sppa: object['file_document_sppa'],

    );
  }
  static Future<PostDataSPPA> connectToAPI(
      String id_data_klaiment, 
      String peserta_1, 
      String jenis_kelamin_peserta_1,
      String tgl_lahir_peserta_1, 
      String peserta_2, 
      String jenis_kelamin_peserta_2,
      String tgl_lahir_peserta_2, 
      String foto_ktp_peserta, 
      String foto_tanda_tangan, 
      String uuid_fileName, 
      String uuid_fileName_ttd, 
      String file_document_sppa
      
      ) async {
    var apiResult = await http.post(
      Uri.parse(DATA_SPPA_STORE),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: {
        "id_data_klaiment": id_data_klaiment,
        "peserta_1": peserta_1,
        "jenis_kelamin_peserta_1": jenis_kelamin_peserta_1,
        "tgl_lahir_peserta_1": tgl_lahir_peserta_1,
        "peserta_2": peserta_2,
        "jenis_kelamin_peserta_2": jenis_kelamin_peserta_2,
        "tgl_lahir_peserta_2": tgl_lahir_peserta_2,
        "foto_ktp_peserta": foto_ktp_peserta,
        "foto_tanda_tangan": foto_tanda_tangan,
        "uuid_fileName": uuid_fileName,
        "uuid_fileName_ttd": uuid_fileName_ttd,
        "file_document_sppa": file_document_sppa,

      },
    );
    print(apiResult.body);
    var jsonObject = json.decode(apiResult.body);
    return PostDataSPPA.createPostDataSPPA(jsonObject);
  }
}