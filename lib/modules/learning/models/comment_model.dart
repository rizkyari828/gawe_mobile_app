// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.status,
    this.message,
    this.comment,
  });

  int status;
  String message;
  List<Comment> comment;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    status: json["status"],
    message: json["message"],
    comment: List<Comment>.from(json["comment"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "comment": List<dynamic>.from(comment.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.nama,
    this.picture,
    this.comment,
  });

  String nama;
  String picture;
  String comment;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    nama: json["nama"],
    picture: json["picture"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "picture": picture,
    "comment": comment,
  };
}
