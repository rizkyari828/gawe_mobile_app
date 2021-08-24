import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/models/comment_model.dart';
import 'package:gaweid2/modules/learning/models/count_like_comment.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LearningNetworkConfig {
  // final baseUrl = "http://192.168.43.215/news_server/index.php/Api/";
  // final baseUrl = "https://testing.gawe.id/api_apps/";
  final baseUrl = "https://gawe.id/api_apps/";
}

abstract class BaseEndPointLearning {
  Future saveRating(String email, String idMateri, String rating, String comment);
  Future saveComment(String email, String idMateri, String comment);
  Future saveLike(String email, String idMateri, String status);
  Future getComment(String idMateri);
  Future countLikeComment(String email, String idMateri);
}

class LearningProvider extends ChangeNotifier implements BaseEndPointLearning {
  @override
  Future saveRating(String email, String idMateri, String rating, String comment) async {
    print("id materi ${idMateri}");
    final response =
    await http.post(LearningNetworkConfig().baseUrl + "apps_learning/saveRating", body: {
      'email': email,
      'id_materi': idMateri,
      'rating': rating,
      'keterangan': comment,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${listData}");
    return listData;
  }

  @override
  Future getComment(String idMateri) async {
    print("id materi ${idMateri}");
    final response =
    await http.post(LearningNetworkConfig().baseUrl + "apps_learning/getComment", body: {
      'id_materi': idMateri,
    });

    final jsondata = jsonDecode(response.body);
    // print("registrasi${jsondata}");

    CommentModel listData = CommentModel.fromJson(jsondata);
    print("registrasi${listData}");
    return listData;

  }

  @override
  Future saveComment(String email, String idMateri, String comment) async {
    print("id materi ${idMateri}");
    final response =
    await http.post(LearningNetworkConfig().baseUrl + "apps_learning/save_comment", body: {
      'email': email,
      'id_materi': idMateri,
      'comment': comment,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${listData}");
    return listData;
  }

  @override
  Future saveLike(String email, String idMateri, String status) async {
    print("id materi ${idMateri}");
    print("status ${status}");

    final response =
    await http.post(LearningNetworkConfig().baseUrl + "apps_learning/save_like", body: {
      'email': email,
      'id_materi': idMateri,
      'status': status,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${listData}");
    return listData;
  }

  @override
  Future countLikeComment(String email, String idMateri) async {
    print("id materi ${idMateri}");
    print("status ${email}");

    final response =
    await http.post(LearningNetworkConfig().baseUrl + "apps_learning/getCountingCommentAndLike", body: {
      'email': email,
      'id_materi': idMateri,
    });

    final jsondata = jsonDecode(response.body);
    CountLikeCommentModel listData = CountLikeCommentModel.fromJson(jsondata);
    print("registrasi${listData}");
    return listData;
  }
}