import 'dart:convert';

import 'package:gaweid2/utils/models/versionModel.dart';
import 'package:get/get.dart';

class UsersProvider extends GetConnect {
  String url = 'https://gawe.id/api_apps/apps/';

  UsersProvider() {
    httpClient.baseUrl = url;
    httpClient.defaultContentType = 'application/json';
  }

  Future<List<dynamic>> getReferral() async {
    try {
      final response = await get('get_referral');
      var listdata = jsonDecode(response.body);
      // print(listdata['data']);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        // print(response.body['data']);
        return listdata['data'];
      }
    } catch (exception){
      return Future.error(exception.toString());
    }
  }
}