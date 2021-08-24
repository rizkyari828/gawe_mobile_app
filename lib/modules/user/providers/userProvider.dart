import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:async/async.dart';

class NetworkConfig {
  final baseUrl = "https://gawe.id/api_apps/";
}

abstract class BaseEndPointUser {
  Future aktifkanAkunUser(String email, otp);
}

class UserProvider extends ChangeNotifier implements BaseEndPointUser {
  @override
  Future aktifkanAkunUser(String email, otp) async {
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/aktivasiUserOtp", body: {
      'email': email,
      'otp': otp,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }
}