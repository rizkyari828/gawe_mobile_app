// To parse this JSON data, do
//
//     final modelOverview = modelOverviewFromJson(jsonString);

import 'dart:convert';

ModelOverview modelOverviewFromJson(String str) => ModelOverview.fromJson(json.decode(str));

String modelOverviewToJson(ModelOverview data) => json.encode(data.toJson());

class ModelOverview {
  ModelOverview({
    this.status,
    this.message,
    this.category,
  });

  int status;
  String message;
  List<Category> category;

  factory ModelOverview.fromJson(Map<String, dynamic> json) => ModelOverview(
    status: json["status"],
    message: json["message"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.idCategori,
    this.desc,
    this.kodeRefferal,
    this.allmateri,
  });

  String id;
  dynamic idCategori;
  dynamic desc;
  String kodeRefferal;
  int allmateri;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    idCategori: json["id_categori"],
    desc: json["desc"],
    kodeRefferal: json["kode_refferal"],
    allmateri: json["allmateri"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_categori": idCategori,
    "desc": desc,
    "kode_refferal": kodeRefferal,
    "allmateri": allmateri,
  };
}
