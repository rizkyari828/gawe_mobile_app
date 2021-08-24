import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gaweid2/modules/learning/models/soal_modul.dart';

import 'package:http/http.dart' as http;

import 'NetworkProvider.dart';

class NetworkP extends ChangeNotifier{

  List listData = [];

  NetworkP.init() {
    this.getPost();
  }


//  SoalModul _post;
//  SoalModul get posts => _post;
//  set posts(SoalModul val){
//    _post = val;
//    notifyListeners();
//  }
//
//  var _id = 1;
//  int get idPost => _id;
//  set idPost(int val){
//    if(val != 0){
//      _id = val;
//    }
//    notifyListeners();
//
//  }


//  Future getPost()async{
//
//
//
//    final response = await http.get("https://jsonplaceholder.typicode.com/posts/1");
//    posts = SoalModul.fromJson(jsonDecode(response.body));
//    return posts;
//
////    final response = await http.post(NetworkConfig().baseUrl + "apps_learning/learn", body: {
////      'jenis_access': 1,
////      'id_materi': 37,
////      'id1': '1',
////      'email': 'ajie.darmawan106@gmail.com',
////    });
////      posts = SoalModul.fromJson(jsonDecode(response.body));
////      return posts;
//
//
//
//  }

  void getPost() async {

      //final response = await http.get("https://jsonplaceholder.typicode.com/posts");
      var res = await http.get('https://jsonplaceholder.typicode.com/posts');
      if (res.statusCode == 200) {
        listData = res.bodyBytes;
      }
      notifyListeners();
//    } on DioError catch (e) {
//      log("Error Dio : $e");
//    } catch (ex) {
//      log("Error Exception : $ex");
//    }

  }





}