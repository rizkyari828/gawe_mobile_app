import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/lowongan/models/detailLowongan.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LowonganNetworkConfig {
  // final baseUrl = "http://192.168.43.215/news_server/index.php/Api/";
  // final baseUrl = "https://testing.gawe.id/api_apps/";
  final baseUrl = "https://gawe.id/api_apps/";
}

abstract class BaseEndPointLowongan {
  Future detailLowongan(String idLowongan, String idEmployee);
}

class LowonganProvider extends ChangeNotifier implements BaseEndPointLowongan {
  @override
  Future detailLowongan(String idLowongan, String idEmployee) async {
    var response = await http.get(LowonganNetworkConfig().baseUrl+"apps/detail_lowongan?id_lowongan="+idLowongan+"&id_employee="+idEmployee);
    final jsondata = jsonDecode(response.body);

    DetailLowonganModel listdata = DetailLowonganModel.fromJson(jsondata);

    return listdata;
  }
}