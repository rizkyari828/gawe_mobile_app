// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'dart:convert';

List<ModelNews> modelNewsFromJson(String str) => List<ModelNews>.from(json.decode(str).map((x) => ModelNews.fromJson(x)));

String modelNewsToJson(List<ModelNews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelNews {
  String id;
  String title;
  String foto;
  String desc;
  DateTime dateCreated;

  ModelNews({
    this.id,
    this.title,
    this.foto,
    this.desc,
    this.dateCreated,
  });

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
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
