// To parse this JSON data, do
//
//     final countLikeCommentModel = countLikeCommentModelFromJson(jsonString);

import 'dart:convert';

CountLikeCommentModel countLikeCommentModelFromJson(String str) => CountLikeCommentModel.fromJson(json.decode(str));

String countLikeCommentModelToJson(CountLikeCommentModel data) => json.encode(data.toJson());

class CountLikeCommentModel {
  CountLikeCommentModel({
    this.status,
    this.message,
    this.like,
  });

  int status;
  String message;
  Like like;

  factory CountLikeCommentModel.fromJson(Map<String, dynamic> json) => CountLikeCommentModel(
    status: json["status"],
    message: json["message"],
    like: Like.fromJson(json["like"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "like": like.toJson(),
  };
}

class Like {
  Like({
    this.countLike,
    this.countComment,
    this.statusLike,
    this.statusRate,
    this.lastComment,
  });

  int countLike;
  int countComment;
  int statusLike;
  int statusRate;
  LastComment lastComment;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    countLike: json["count_like"],
    countComment: json["count_comment"],
    statusLike: json["status_like"],
    statusRate: json["status_rate"],
    lastComment: LastComment.fromJson(json["last_comment"]),
  );

  Map<String, dynamic> toJson() => {
    "count_like": countLike,
    "count_comment": countComment,
    "status_like": statusLike,
    "status_rate": statusRate,
    "last_comment": lastComment.toJson(),
  };
}

class LastComment {
  LastComment({
    this.id,
    this.status,
    this.komentar,
    this.idReference,
    this.idUser,
    this.picture,
    this.nama,
  });

  String id;
  String status;
  String komentar;
  String idReference;
  String idUser;
  String picture;
  String nama;

  factory LastComment.fromJson(Map<String, dynamic> json) => LastComment(
    id: json["id"],
    status: json["status"],
    komentar: json["komentar"],
    idReference: json["id_reference"],
    idUser: json["id_user"],
    picture: json["picture"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "komentar": komentar,
    "id_reference": idReference,
    "id_user": idUser,
    "picture": picture,
    "nama": nama,
  };
}
