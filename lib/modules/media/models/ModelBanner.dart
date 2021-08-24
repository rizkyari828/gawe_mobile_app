// To parse this JSON data, do
//
//     final modelBanner = modelBannerFromJson(jsonString);

import 'dart:convert';

List<ModelBanner> modelBannerFromJson(String str) => List<ModelBanner>.from(json.decode(str).map((x) => ModelBanner.fromJson(x)));

String modelBannerToJson(List<ModelBanner> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelBanner {
  ModelBanner({
    this.id,
    this.metaTitle,
    this.file,
    this.link,
    this.status,
  });

  String id;
  String metaTitle;
  String file;
  String link;
  String status;

  factory ModelBanner.fromJson(Map<String, dynamic> json) => ModelBanner(
    id: json["id"],
    metaTitle: json["meta_title"],
    file: json["file"],
    link: json["link"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "meta_title": metaTitle,
    "file": file,
    "link": link,
    "status": status,
  };
}
