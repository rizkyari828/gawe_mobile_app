// To parse this JSON data, do
//
//     final modelCheckDw = modelCheckDwFromJson(jsonString);

import 'dart:convert';

ModelCheckDw modelCheckDwFromJson(String str) => ModelCheckDw.fromJson(json.decode(str));

String modelCheckDwToJson(ModelCheckDw data) => json.encode(data.toJson());

class ModelCheckDw {
  ModelCheckDw({
    this.status,
    this.message,
    this.id,
    this.client,
    this.penempatan,
    this.mulai,
    this.selesai,
    this.posisi,
    this.status_active,
    this.job_order,
    this.status_bloc,
  });

  int status;
  String message;
  String id;
  String client;
  String penempatan;
  String mulai;
  String selesai;
  String posisi;
  String status_active;
  String job_order;
  String status_bloc;

  factory ModelCheckDw.fromJson(Map<String, dynamic> json) => ModelCheckDw(
    status: json["status"],
    message: json["message"],
    id: json["id"],
    client: json["client"],
    penempatan: json["penempatan"],
    mulai: json["mulai"],
    selesai: json["selesai"],
    posisi: json["posisi"],
    status_active: json["status_active"],
    job_order: json["job_order"],
    status_bloc: json["status_bloc"],



  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "id": id,
    "client": client,
    "penempatan": penempatan,
    "mulai": mulai,
    "selesai": selesai,
    "posisi": posisi,
    "status_active": status_active,
    "job_order": job_order,
    "status_bloc": status_bloc,

  };
}
