// To parse this JSON data, do
//
//     final mediaModel = mediaModelFromJson(jsonString);

import 'dart:convert';

MediaModel mediaModelFromJson(String str) => MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  MediaModel({
    this.status,
    this.message,
    this.media,
  });

  String status;
  String message;
  List<Media> media;

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
    status: json["status"],
    message: json["message"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Media {
  Media({
    this.id,
    this.title,
    this.foto,
    this.desc,
    this.dateCreated,
  });

  String id;
  String title;
  String foto;
  String desc;
  DateTime dateCreated;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    title: json["title"],
    foto: json["foto"],
    desc: json["desc"],
    dateCreated: DateTime.parse(json["date_created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "foto": foto,
    "desc": desc,
    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
  };
}
