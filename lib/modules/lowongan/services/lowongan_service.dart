import 'dart:convert';
import 'dart:developer';

import 'package:gaweid2/modules/lowongan/models/coin.dart';
import 'package:gaweid2/modules/lowongan/models/lowongan_model_pagination.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  getCoins([String id,String section, String url]) async {
    var data = await http.get(url ?? NetworkConfig().baseUrl+"apps/lowongan_pagination?id="+id+"&section="+section);
    print(data.body);
    LowonganPagination listdata = lowonganPaginationFromJson(data.body);
    // print(listdata);
    return listdata;
  }

  getApi(String id,String section, int start) {
    final mainUrl = NetworkConfig().baseUrl+"apps/lowongan_pagination?id="+id+"&section="+section+"&start=";
    return mainUrl + start.toString() + "&limit=50";
  }
}

final apiHelper = ApiHelper();
