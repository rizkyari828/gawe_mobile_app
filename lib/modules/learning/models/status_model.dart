// To parse this JSON data, do
//
//     final statusMateriModel = statusMateriModelFromJson(jsonString);

import 'dart:convert';

StatusMateriModel StatusMateriModelFromJson(String str) => StatusMateriModel.fromJson(json.decode(str));

String soalModulToJson(StatusMateriModel data) => json.encode(data.toJson());

class StatusMateriModel {
  StatusMateriModel({
    this.status,
    this.message,
    this.statusMateri,
    this.statusPretest,
    this.statusPostest,
  });

  int status;
  String message;
  String statusMateri;
  String statusPretest;
  String statusPostest;

  factory StatusMateriModel.fromJson(Map<String, dynamic> json) => StatusMateriModel(
    status: json["status"],
    message: json["message"],
    statusMateri: json["status_materi"],
    statusPretest: json["status_pretest"],
    statusPostest: json["status_postest"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "status_materi": statusMateri,
    "status_pretest": statusPretest,
    "status_postest": statusPostest,
  };
}
